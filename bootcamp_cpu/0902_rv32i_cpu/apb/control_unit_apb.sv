
module control_unit
  import rv32_pkg::*;
(
  input   logic        clk, rst_n,
  input   logic [31:0] instr_code,
  input   logic        ready,
  output  logic        pc_en,
  output  logic        rf_we,
  output  logic        alusrc_sel,
  output  logic [ 3:0] alu_control,
  output  logic        dwe,
  output  logic [ 2:0] itype, // instruction type : funct3
  output  logic [ 2:0] rfsrc_sel,
  output  logic        branch,
  output  logic        jal,
  output  logic        jalr,
  output  logic        bus_we,
  output  logic        transfer
);

  logic [2:0] funct3;
  typedef enum logic [2:0] {
    FETCH,
    DECODE,
    EXECUTE,
    MEM,
    WB
  } state_e;

  state_e c_state, n_state;
  opcode_e opcode;

  assign opcode = opcode_e'(instr_code[6:0]);
  //assign rv32i_instr =
  assign funct3 = instr_code[14:12];

  always_ff @(posedge clk) begin
    if(!rst_n) begin
      c_state <= FETCH;
    end else begin
      c_state <= n_state;
    end
  end

  always_comb begin
    rf_we       = 1'b0;
    alusrc_sel  = 1'b0;
    alu_control = 4'b0_000;   // {funct7[5], funct3}
    dwe         = 1'b0;
    itype       = 3'b010;     // SW, LW
    rfsrc_sel   = 1'b0;
    branch      = 1'b0;
    jal         = 1'b0;
    jalr        = 1'b0;
    pc_en       = 1'b0;
    bus_we      = 1'b0;
    transfer    = 1'b0;
    n_state     = c_state;
    case(c_state)
      FETCH : begin
        pc_en = 1'b1;
        n_state = DECODE;
      end
      DECODE : begin
        n_state = EXECUTE;
      end
      EXECUTE : begin
        case(opcode)
          OP_RTYPE :  begin
            rf_we       = 1'b1;
            alusrc_sel  = 1'b0;
            alu_control = {instr_code[30],instr_code[14:12]};
            rfsrc_sel   = 3'b000;   // WB
            n_state     = FETCH;
          end
          OP_BTYPE :  begin
            alusrc_sel  = 1'b0;
            alu_control = {1'b1,funct3};
            branch      = 1'b1;
            n_state     = FETCH;
          end
          OP_STYPE : begin
            alusrc_sel  = 1'b1;
            alu_control = 4'b0000;
            n_state     = MEM;
          end
          OP_ITYPE : begin
            rf_we       = 1'b1;
            alusrc_sel  = 1'b1;
            rfsrc_sel   = 3'b000;
            if(funct3 == 3'b101)
              alu_control = {instr_code[30],funct3};
            else
              alu_control = {1'b0,funct3};
            dwe         = 1'b0;
            itype       = 3'b111;   // for : data memi
            n_state     = FETCH;
          end
          OP_ILTYPE:  begin 
            alusrc_sel  = 1'b1;
            alu_control = 4'b0000;
            n_state     = MEM;
          end
          OP_UTYPE :  begin
            rf_we       = 1'b1;
            rfsrc_sel   = 3'b011;
            n_state     = FETCH;
          end
          OP_UATYPE : begin
            rf_we       = 1'b1;
            rfsrc_sel   = 3'b011;
            n_state     = FETCH;
          end
          OP_JTYPE :  begin
            rf_we       = 1'b1;
            rfsrc_sel   = 3'b100;
            jal         = 1'b1;
            n_state     = FETCH;
          end
          OP_JLTYPE:  begin
            rf_we       = 1'b1;
            rfsrc_sel   = 3'b100;
            jalr        = 1'b1;
            n_state     = FETCH;
          end
        endcase
      end
      MEM: begin
        itype     = funct3;
        transfer  = 1'b1;
        if(opcode == OP_STYPE) begin
          bus_we  = 1'b1;
          if(ready)
            n_state = FETCH;
        end
        if(opcode == OP_ILTYPE) begin
          n_state = WB;
        end
      end
      WB : begin
        rf_we       = 1'b1;
        rfsrc_sel   = 3'b001;
        if(ready)
          n_state     = FETCH;
      end
      default : n_state = FETCH;
    endcase
  end
endmodule

