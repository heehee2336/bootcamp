module fifo_uvm #(
  parameter WIDTH = 4
)(
  input   logic         clk,
  input   logic         rst_n,
  input   logic [7:0]  wdata,
  input   logic         push,
  input   logic         pop,
  output  logic         full,
  output  logic         empty,
  output  logic [7:0]  rdata
);


    logic [WIDTH -1 :0] w_wptr, w_rptr;

    register #(
        .WIDTH (4)
    )U_REGISTER(
        .clk(clk),
        .we((~full & push)),
        .waddr(w_wptr),
        .wdata(wdata),
        .raddr(w_rptr),
        .rdata(rdata)
    );

    control_unit #(
        .WIDTH (4)
    )U_CONTROL_UNIT(
        .clk(clk),
        .reset(~rst_n),
        .push(push),
        .pop(pop),
        .wptr(w_wptr),
        .rptr(w_rptr),
        .full(full),
        .empty(empty)
);

endmodule

module register #(
    parameter WIDTH = 4
    )(
    input  logic                clk,
    input  logic                we,
    input  logic [WIDTH -1 :0]  waddr,
    input  logic [7 : 0]       wdata,
    input  logic [WIDTH -1 :0]  raddr,
    output logic [7: 0]        rdata
);
    parameter DEPTH = 2**WIDTH;
    logic [15:0] register_file[0:DEPTH-1];

    assign rdata = register_file[raddr];

    always_ff @(posedge clk) begin
        if (we) begin
            register_file[waddr] <= wdata;
            // waddr <= waddr + 1;
        end
    end
endmodule

module control_unit #(
    parameter WIDTH = 4
    )(
    input   logic               clk,
    input   logic               reset,
    input   logic               push,
    input   logic               pop,
    output  logic [WIDTH - 1:0] wptr,
    output  logic [WIDTH - 1:0] rptr,
    output  logic               full,
    output  logic               empty
);

    logic [WIDTH -1 :0] wptr_reg, wptr_next;
    logic  [WIDTH -1 :0] rptr_reg, rptr_next;
    logic full_reg, full_next;
    logic empty_reg, empty_next;

    assign wptr = wptr_reg;
    assign rptr = rptr_reg;
    assign full = full_reg;
    assign empty = empty_reg;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            wptr_reg <= 1'b0;
            rptr_reg <= 1'b0;
            empty_reg <=1'b1;
            full_reg <= 1'b0;
        end else begin
            wptr_reg <= wptr_next;
            rptr_reg <= rptr_next;
            full_reg <= full_next;
            empty_reg <= empty_next;
        end
    end

    always_comb begin
        wptr_next = wptr_reg;
        rptr_next = rptr_reg;
        full_next = full_reg;
        empty_next = empty_reg;
        case({push, pop})
            2'b00 : begin
                //init
            end
            2'b01 : begin
                //pop only
                if(!empty_reg) begin
                    rptr_next = rptr_reg + 1;
                    full_next = 0;
                    if (wptr_reg == rptr_next) empty_next = 1'b1;
                end
            end
            2'b10 : begin
                //push only
                if (!full_reg) begin
                    wptr_next = wptr_reg + 1;
                    empty_next = 0;
                    if (wptr_next == rptr_reg) full_next = 1'b1;
                end
            end
            2'b11 : begin
                //pop & push 1
                if (full) begin
                    rptr_next = rptr_reg + 1;
                    full_next = 1'b0;
                end else if (empty) begin
                    wptr_next = wptr_reg + 1;
                    empty_next = 1'b0;
                end else begin
                    wptr_next = wptr_reg + 1;
                    rptr_next = rptr_reg + 1;
                end
            end
        endcase
    end
endmodule

