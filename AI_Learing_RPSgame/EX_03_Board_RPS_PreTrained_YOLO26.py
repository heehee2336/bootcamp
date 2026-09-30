# 모듈 로딩
import tflite_runtime.interpreter as tflite
import numpy as np
from pathlib import Path
import time
import cv2

SCRIPT_DIR = Path(__file__).resolve().parent
MODEL_PATH = SCRIPT_DIR / "best_float32_26_2.tflite"
print('model path:', MODEL_PATH)
if not MODEL_PATH.is_file():
    raise FileNotFoundError(f"Custom TFLite model not found: {MODEL_PATH}")

# LiteRT 모델 로딩
interpreter = tflite.Interpreter(model_path=str(MODEL_PATH)) # 모델 로딩
interpreter.allocate_tensors() # tensor 할당

# 모델 정보 얻기 
input_details = interpreter.get_input_details()  # input tensor 정보 얻기
output_details = interpreter.get_output_details() # output tensor 정보 얻기
print(input_details)
print(output_details)
input_index = input_details[0]['index']
output_index = output_details[0]['index']
input_dtype = input_details[0]['dtype']
output_dtype = output_details[0]['dtype']
height = input_details[0]['shape'][1]
width = input_details[0]['shape'][2]
print('model input shape:', (height, width))

# BB 텍스트 및 색상 정의
class_names = {0: 'scissors', 1: 'rock', 2: 'paper'}
class_count = len(class_names)
output_shape = output_details[0]['shape']
if len(output_shape) != 3 or output_shape[0] != 1 or output_shape[2] != 6:
    raise ValueError(f"Unexpected model output shape: {output_details[0]['shape']}")

# Threshold 설정
CONF_TH = 0.5
IOU_TH = 0.45
AMBIGUITY_MARGIN = 0.20
ROUND_COUNT = 3
PHASE_SECONDS = 1.0
GESTURE_STEP_SECONDS = 1.0
ROUND_RESULT_SECONDS = 3.0
ROUND_INTRO_SECONDS = 1.0

# HUD appearance settings: colors use OpenCV's BGR order.
SCORE_FONT_SCALE = 0.62
RESULT_FONT_SCALE = 0.78
PROMPT_FONT_SCALE = 0.58
HUD_BACKGROUND_COLOR = (24, 27, 29)
SCORE_COLOR = (245, 245, 245)
RESULT_COLOR = (235, 235, 235)
FINAL_WINNER_COLOR = (70, 220, 255)
PROMPT_COLOR = (205, 215, 215)
LEFT_COLOR = (255, 0, 0)
RIGHT_COLOR = (0, 0, 255)
DIVIDER_COLOR = (115, 125, 125)
READY_COLOR = (255, 0, 180)
UI_BACKGROUND_COLOR = (250, 250, 250)
CAMERA_BACKGROUND_COLOR = (220, 220, 220)
UI_WIDTH = 640
UI_HEIGHT = 550
CAMERA_VIEW = (24, 96, 592, 330)

def letterbox(img, new_shape, color=(114, 114, 114)):
    h, w = img.shape[:2]
    nh, nw = new_shape
    r = min(nw / w, nh / h)

    new_w, new_h = int(w * r), int(h * r)
    resized = cv2.resize(img, (new_w, new_h))

    pad_w = nw - new_w
    pad_h = nh - new_h
    pad_x = pad_w // 2
    pad_y = pad_h // 2

    padded = cv2.copyMakeBorder(
        resized,
        pad_y, pad_y,
        pad_x, pad_x,
        cv2.BORDER_CONSTANT,
        value=color
    )

    return padded, r, pad_x, pad_y

def box_iou(box_a, box_b):
    x1 = max(box_a[0], box_b[0])
    y1 = max(box_a[1], box_b[1])
    x2 = min(box_a[2], box_b[2])
    y2 = min(box_a[3], box_b[3])
    intersection = max(0, x2 - x1) * max(0, y2 - y1)
    area_a = max(0, box_a[2] - box_a[0]) * max(0, box_a[3] - box_a[1])
    area_b = max(0, box_b[2] - box_b[0]) * max(0, box_b[3] - box_b[1])
    return intersection / (area_a + area_b - intersection + 1e-6)

def nms(boxes, scores, class_ids, iou_th):
    if not boxes:
        return []

    keep = []
    order = np.argsort(scores)[::-1]
    while order.size:
        i = int(order[0])
        keep.append(i)
        order = np.array([
            j for j in order[1:]
            if class_ids[j] != class_ids[i] or box_iou(boxes[i], boxes[j]) <= iou_th
        ])

    return keep

def process_image(frame):

    # BGR을 RGB로 변경
    img_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

    # letterbox 적용
    img_lb, r, pad_x, pad_y = letterbox(img_rgb, (height, width))

    # 0 ~ 1 사이 값으로 변경
    img = img_lb.astype(np.float32) / 255.0

    # 모델 입력 형태로 수정
    img = np.expand_dims(img, axis=0)

    if np.issubdtype(input_dtype, np.integer):
        input_scale, input_zero = input_details[0]['quantization']
        if input_scale <= 0:
            raise ValueError('Quantized model input has no valid scale')
        limits = np.iinfo(input_dtype)
        img = np.clip(np.rint(img / input_scale + input_zero), limits.min, limits.max)
    img = img.astype(input_dtype)

    # 모델에 입력하여 결과 얻기
    #   input tensor 설정
    interpreter.set_tensor(input_index, img)
    #   모델 실행
    interpreter.invoke()
    # YOLO26 TFLite output: (1, 300, 6), with normalized xyxy, score, class id.
    raw = interpreter.get_tensor(output_index)[0]

    if np.issubdtype(output_dtype, np.integer):
        output_scale, output_zero = output_details[0]['quantization']
        if output_scale <= 0:
            raise ValueError('Quantized model output has no valid scale')
        raw = (raw.astype(np.float32) - output_zero) * output_scale

    # 결과 중 CONF_TH 이상만 모으기
    boxes, scores, class_ids = [], [], []

    for det in raw:
        x1, y1, x2, y2 = det[:4]
        score = float(det[4])
        cls_id = int(round(float(det[5])))
        if cls_id not in class_names or score < CONF_TH:
            continue

        x1 = (x1 * width - pad_x) / r
        y1 = (y1 * height - pad_y) / r
        x2 = (x2 * width - pad_x) / r
        y2 = (y2 * height - pad_y) / r

        boxes.append([
            int(np.clip(x1,0,frame.shape[1])),
            int(np.clip(y1,0,frame.shape[0])),
            int(np.clip(x2,0,frame.shape[1])),
            int(np.clip(y2,0,frame.shape[0]))
        ])
        scores.append(score)
        class_ids.append(cls_id)

    # NMS 적용
    keep = nms(boxes, scores, class_ids, IOU_TH)

    detections = [(boxes[i], class_ids[i], scores[i]) for i in keep]
    players = {'left': None, 'right': None}
    ambiguous_sides = set()
    detections_by_side = {'left': [], 'right': []}

    for box, class_id, score in detections:
        x1, y1, x2, y2 = box
        side = 'left' if (x1 + x2) / 2 < frame.shape[1] / 2 else 'right'
        detections_by_side[side].append((box, class_id, score))
        side_color = LEFT_COLOR if side == 'left' else RIGHT_COLOR
        cv2.rectangle(frame, (x1, y1), (x2, y2), side_color, 2)
        cv2.putText(frame, f'{side.upper()} {class_names[class_id]}',
                    (x1, max(y1 - 7, 18)), cv2.FONT_HERSHEY_PLAIN, 1.5,
                    side_color, 2)

    for side, side_detections in detections_by_side.items():
        if not side_detections:
            continue
        side_detections.sort(key=lambda detection: detection[2], reverse=True)
        best_box, best_class, best_score = side_detections[0]
        ambiguous = any(
            class_id != best_class
            and box_iou(best_box, box) > 0.5
            and best_score - score < AMBIGUITY_MARGIN
            for box, class_id, score in side_detections[1:]
        )
        if ambiguous:
            ambiguous_sides.add(side)
        else:
            players[side] = (best_class, best_score)
    return players, ambiguous_sides

# 카메라 설정
cap = cv2.VideoCapture(0)
if not cap.isOpened():
    raise RuntimeError('Could not open camera 0')
cap.set(cv2.CAP_PROP_FRAME_WIDTH, 480)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)
cap.set(cv2.CAP_PROP_BUFFERSIZE, 1)

# 윈도우 설정
cv2.namedWindow('RPS Camera Game', cv2.WINDOW_NORMAL)
cv2.resizeWindow('RPS Camera Game', UI_WIDTH, UI_HEIGHT)

left_wins = 0
right_wins = 0
round_number = 0
game_state = 'waiting'
state_started_at = 0.0
round_result_until = 0.0
round_message = 'Press SPACE to start'
final_winner = None
round_choices = {'left': None, 'right': None}
captured_frame = None

def start_game():
    global left_wins, right_wins, round_number, game_state, round_message
    global state_started_at, final_winner, round_choices, captured_frame
    left_wins = 0
    right_wins = 0
    round_number = 1
    game_state = 'waiting_hands'
    state_started_at = time.time()
    round_message = 'Round 1'
    final_winner = None
    round_choices = {'left': None, 'right': None}
    captured_frame = None

def draw_centered_text(image, text, y, scale, color, thickness=1):
    text_size = cv2.getTextSize(text, cv2.FONT_HERSHEY_SIMPLEX, scale, thickness)[0]
    x = max((image.shape[1] - text_size[0]) // 2, 8)
    cv2.putText(image, text, (x, y), cv2.FONT_HERSHEY_SIMPLEX,
                scale, color, thickness, cv2.LINE_AA)

def draw_dotted_line(image, x, y_start, y_end, color, thickness=2):
    for y in range(y_start, y_end, 16):
        cv2.line(image, (x, y), (x, min(y + 7, y_end)), color, thickness)

def draw_gesture_options(image, center_x, top_y, selected_class, color):
    option_width = 88
    option_gap = 5
    total_width = option_width * class_count + option_gap * (class_count - 1)
    start_x = center_x - total_width // 2
    for class_id, label in class_names.items():
        x = start_x + class_id * (option_width + option_gap)
        selected = selected_class == class_id
        border_color = color if selected else (185, 185, 185)
        thickness = 2 if selected else 1
        cv2.rectangle(image, (x, top_y), (x + option_width, top_y + 30),
                      border_color, thickness)
        label_size = cv2.getTextSize(label.upper(), cv2.FONT_HERSHEY_SIMPLEX,
                                     0.34, 1)[0]
        label_x = x + (option_width - label_size[0]) // 2
        cv2.putText(image, label.upper(), (label_x, top_y + 20),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.34,
                    color if selected else (90, 90, 90), 1, cv2.LINE_AA)

def draw_status_banner(image, text, center_x, center_y, scale, color):
    text_size = cv2.getTextSize(text, cv2.FONT_HERSHEY_SIMPLEX, scale, 3)[0]
    half_width = text_size[0] // 2 + 28
    half_height = text_size[1] // 2 + 22
    x1 = max(8, center_x - half_width)
    x2 = min(image.shape[1] - 8, center_x + half_width)
    y1 = max(8, center_y - half_height)
    y2 = min(image.shape[0] - 8, center_y + half_height)
    overlay = image.copy()
    cv2.rectangle(overlay, (x1, y1), (x2, y2), (20, 20, 20), -1)
    cv2.addWeighted(overlay, 0.82, image, 0.18, 0, image)
    draw_centered_text(image, text, center_y + text_size[1] // 2,
                       scale, color, 3)

def draw_result_badge(image, text, x, y, color):
    text_size = cv2.getTextSize(text, cv2.FONT_HERSHEY_SIMPLEX, 0.58, 2)[0]
    width = text_size[0] + 24
    height = text_size[1] + 18
    cv2.rectangle(image, (x, y), (x + width, y + height), (20, 20, 20), -1)
    cv2.rectangle(image, (x, y), (x + width, y + height), color, 2)
    cv2.putText(image, text, (x + 12, y + height - 9),
                cv2.FONT_HERSHEY_SIMPLEX, 0.58, (255, 255, 255), 2, cv2.LINE_AA)

try:
    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break

        players, ambiguous_sides = process_image(frame)
        left_player = players['left']
        right_player = players['right']
        both_hands_ready = (
            left_player is not None
            and right_player is not None
            and not ambiguous_sides
        )
        current_time = time.time()

        if game_state == 'waiting_hands' and both_hands_ready:
            game_state = 'recognition_complete'
            state_started_at = current_time
        elif game_state == 'recognition_complete' and current_time - state_started_at >= PHASE_SECONDS:
            game_state = 'ready'
            state_started_at = current_time
        elif game_state == 'ready' and current_time - state_started_at >= PHASE_SECONDS:
            game_state = 'start'
            state_started_at = current_time
        elif game_state == 'start' and current_time - state_started_at >= PHASE_SECONDS:
            game_state = 'gesture_countdown'
            state_started_at = current_time
        elif game_state == 'gesture_countdown':
            elapsed = current_time - state_started_at
            if elapsed >= GESTURE_STEP_SECONDS * 3:
                if both_hands_ready:
                    left_class = left_player[0]
                    right_class = right_player[0]
                    if left_class == right_class:
                        outcome = 'DRAW'
                    elif (left_class - right_class) % class_count == 1:
                        left_wins += 1
                        outcome = 'LEFT WINS'
                    else:
                        right_wins += 1
                        outcome = 'RIGHT WINS'
                    round_message = (
                        f"ROUND {round_number}: LEFT {class_names[left_class]}  "
                        f"RIGHT {class_names[right_class]}  {outcome}"
                    )
                    round_choices = {'left': left_class, 'right': right_class}
                    captured_frame = frame.copy()
                    if round_number == ROUND_COUNT:
                        game_state = 'finished'
                        if left_wins > right_wins:
                            final_winner = 'LEFT PLAYER WINS'
                        elif right_wins > left_wins:
                            final_winner = 'RIGHT PLAYER WINS'
                        else:
                            final_winner = 'TIE GAME'
                    else:
                        game_state = 'round_done'
                        state_started_at = current_time
                else:
                    game_state = 'waiting_hands'
                    round_message = 'Both hands must be visible at the end of countdown'
        elif game_state == 'round_done' and current_time - state_started_at >= ROUND_RESULT_SECONDS:
            round_number += 1
            game_state = 'round_intro'
            state_started_at = current_time
            round_choices = {'left': None, 'right': None}
            captured_frame = None
        elif game_state == 'round_intro' and current_time - state_started_at >= ROUND_INTRO_SECONDS:
            game_state = 'waiting_hands'

        if game_state in ('waiting_hands', 'recognition_complete', 'ready', 'start', 'gesture_countdown'):
            if left_player is not None:
                round_choices['left'] = left_player[0]
            if right_player is not None:
                round_choices['right'] = right_player[0]

        if game_state == 'waiting':
            prompt = 'Press SPACE to start'
        elif game_state == 'recognition_complete':
            prompt = 'Both hands detected'
        elif game_state == 'ready':
            prompt = 'Get ready'
        elif game_state == 'start':
            prompt = 'Show one hand on each side'
        elif game_state == 'waiting_hands':
            if ambiguous_sides:
                prompt = 'Unclear gesture - hold both hands clearly'
            elif left_player is None or right_player is None:
                prompt = 'Both players: show one hand on your side'
            else:
                prompt = 'Get ready'
        elif game_state == 'gesture_countdown':
            prompt = 'Hold your gesture until the countdown ends'
        elif game_state == 'round_done':
            prompt = 'Next round'
        elif game_state == 'round_intro':
            prompt = 'Get ready for the next round'
        elif game_state == 'finished':
            prompt = 'Press SPACE to play again'

        frame_height, frame_width = frame.shape[:2]
        canvas = np.full((UI_HEIGHT, UI_WIDTH, 3), UI_BACKGROUND_COLOR, dtype=np.uint8)
        view_x, view_y, view_width, view_height = CAMERA_VIEW
        canvas[view_y:view_y + view_height, view_x:view_x + view_width] = CAMERA_BACKGROUND_COLOR

        display_frame = (
            captured_frame
            if game_state in ('round_done', 'finished') and captured_frame is not None
            else frame
        )
        display_height, display_width = display_frame.shape[:2]
        scale = min(view_width / display_width, view_height / display_height)
        resized_width = max(1, int(display_width * scale))
        resized_height = max(1, int(display_height * scale))
        resized_frame = cv2.resize(display_frame, (resized_width, resized_height))
        image_x = view_x + (view_width - resized_width) // 2
        image_y = view_y + (view_height - resized_height) // 2
        canvas[image_y:image_y + resized_height, image_x:image_x + resized_width] = resized_frame
        cv2.rectangle(canvas, (view_x, view_y),
                      (view_x + view_width, view_y + view_height), (170, 170, 170), 1)
        center_x = UI_WIDTH // 2
        center_y = view_y + view_height // 2
        if game_state in ('round_done', 'finished') and captured_frame is not None:
            left_choice = round_choices['left']
            right_choice = round_choices['right']
            if left_choice is not None:
                draw_result_badge(
                    canvas, f'LEFT: {class_names[left_choice].upper()}',
                    view_x + 12, view_y + 12, LEFT_COLOR
                )
            if right_choice is not None:
                right_text = f'RIGHT: {class_names[right_choice].upper()}'
                right_width = cv2.getTextSize(
                    right_text, cv2.FONT_HERSHEY_SIMPLEX, 0.58, 2
                )[0][0] + 24
                draw_result_badge(
                    canvas, right_text, view_x + view_width - right_width - 12,
                    view_y + 12, RIGHT_COLOR
                )
        draw_dotted_line(canvas, center_x, view_y + 18,
                         view_y + view_height - 18, DIVIDER_COLOR, 1)

        draw_centered_text(canvas, 'SCORE', 37, 0.72, (20, 20, 20), 1)
        score_items = [
            (str(left_wins), LEFT_COLOR),
            (' : ', (20, 20, 20)),
            (str(right_wins), RIGHT_COLOR),
        ]
        score_width = sum(
            cv2.getTextSize(text, cv2.FONT_HERSHEY_SIMPLEX, 1.0, 2)[0][0]
            for text, _ in score_items
        )
        score_x = (UI_WIDTH - score_width) // 2
        for text, color in score_items:
            cv2.putText(canvas, text, (score_x, 82), cv2.FONT_HERSHEY_SIMPLEX,
                        1.0, color, 2, cv2.LINE_AA)
            score_x += cv2.getTextSize(
                text, cv2.FONT_HERSHEY_SIMPLEX, 1.0, 2
            )[0][0]

        round_label = f'ROUND {round_number}/{ROUND_COUNT}' if round_number else 'ROCK  PAPER  SCISSORS'
        cv2.putText(canvas, round_label, (view_x + 10, view_y + 24),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.45, (55, 55, 55), 1, cv2.LINE_AA)

        if game_state in ('waiting', 'waiting_hands'):
            center_text = 'PRESS SPACE TO START' if game_state == 'waiting' else 'SHOW BOTH HANDS'
            center_color = (55, 55, 55)
            center_scale = 0.62
        elif game_state == 'recognition_complete':
            center_text, center_color, center_scale = 'RECOGNITION COMPLETE', SCORE_COLOR, 0.68
        elif game_state == 'ready':
            center_text, center_color, center_scale = 'READY?', READY_COLOR, 1.2
        elif game_state == 'start':
            center_text, center_color, center_scale = 'START!', READY_COLOR, 1.25
        elif game_state == 'round_intro':
            center_text, center_color, center_scale = f'ROUND {round_number}', READY_COLOR, 0.9
        elif game_state == 'gesture_countdown':
            elapsed = current_time - state_started_at
            gesture_index = min(int(elapsed // GESTURE_STEP_SECONDS), 2)
            center_text = ('SCISSORS', 'ROCK', 'PAPER')[gesture_index]
            center_color, center_scale = (255, 255, 255), 1.3
        elif game_state == 'round_done':
            center_text, center_color, center_scale = 'ROUND RESULT', (55, 55, 55), 0.65
        else:
            center_text, center_color, center_scale = '', SCORE_COLOR, 0.8
        if center_text:
            if game_state in ('recognition_complete', 'ready', 'start', 'gesture_countdown'):
                draw_status_banner(canvas, center_text, center_x, center_y,
                                   center_scale, center_color)
            else:
                draw_centered_text(canvas, center_text, center_y + 12,
                                   center_scale, center_color, 2)

        player_y = view_y + view_height + 42
        left_name_width = cv2.getTextSize(
            'LEFT', cv2.FONT_HERSHEY_SIMPLEX, 0.92, 2
        )[0][0]
        cv2.putText(canvas, 'LEFT', (center_x // 2 - left_name_width // 2, player_y),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.92, LEFT_COLOR, 2, cv2.LINE_AA)
        right_name_width = cv2.getTextSize(
            'RIGHT', cv2.FONT_HERSHEY_SIMPLEX, 0.92, 2
        )[0][0]
        cv2.putText(canvas, 'RIGHT', (center_x + (center_x - right_name_width) // 2,
                                      player_y), cv2.FONT_HERSHEY_SIMPLEX,
                    0.92, RIGHT_COLOR, 2, cv2.LINE_AA)
        draw_gesture_options(canvas, UI_WIDTH // 4, player_y + 13,
                             round_choices['left'], LEFT_COLOR)
        draw_gesture_options(canvas, UI_WIDTH * 3 // 4, player_y + 13,
                             round_choices['right'], RIGHT_COLOR)

        if game_state in ('waiting', 'ready', 'start', 'round_intro', 'waiting_hands', 'recognition_complete'):
            draw_centered_text(canvas, prompt.upper(), UI_HEIGHT - 10,
                               0.42, (80, 80, 80), 1)
        elif game_state == 'round_done':
            draw_centered_text(canvas, round_message, UI_HEIGHT - 10,
                               0.42, (60, 60, 60), 1)

        if game_state == 'finished':
            overlay = canvas.copy()
            cv2.rectangle(overlay, (view_x, center_y - 74),
                          (view_x + view_width, center_y + 74), (235, 235, 235), -1)
            cv2.addWeighted(overlay, 0.88, canvas, 0.12, 0, canvas)
            winner_color = (
                LEFT_COLOR if final_winner == 'LEFT PLAYER WINS'
                else RIGHT_COLOR if final_winner == 'RIGHT PLAYER WINS'
                else FINAL_WINNER_COLOR
            )
            draw_centered_text(canvas, 'GAME OVER', center_y - 12,
                               0.72, (35, 35, 35), 2)
            winner_text = 'TIE GAME' if final_winner == 'TIE GAME' else final_winner.replace(' PLAYER', '') + '!'
            draw_centered_text(canvas, winner_text, center_y + 42,
                               0.95, winner_color, 3)
            draw_centered_text(canvas, prompt.upper(), UI_HEIGHT - 10,
                               0.42, (80, 80, 80), 1)

        cv2.imshow('RPS Camera Game', canvas)

        key = cv2.waitKey(10) & 0xFF
        if key == ord('q'):
            break
        if key == ord(' ') and game_state in ('waiting', 'finished'):
            start_game()

finally:
    cap.release()
    cv2.destroyAllWindows()
