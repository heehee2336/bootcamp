module data_mem(
  input   logic        clk,
  input   logic [31:0] daddr,
  input   logic [31:0] dwdata,
  input   logic        dwe,
  input   logic [ 2:0] itype,
  output  logic [31:0] drdata
);

  logic [31:0] dmem[0:127];

  assign  drdata = dmem[daddr[31:2]];

  always_ff @(posedge clk) begin
    if(dwe) begin
      case(itype)
        //3'b000 : dmem[daddr[ 7:0]] <= dwdata;
        //3'b001 : dmem[daadr[15:0]] <= dwdata;
        3'b010  : dmem[daddr[31:2]]     <= dwdata;
        default : dmem[daddr[31:2]]     <= dmem[daddr];
      endcase
    end
  end

endmodule
