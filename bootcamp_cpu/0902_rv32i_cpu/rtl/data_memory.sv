module data_mem(
  input  logic        clk,
  input  logic [31:0] daddr,
  input  logic [31:0] dwdata,
  input  logic        dwe,
  input  logic [ 2:0] itype,
  output logic [31:0] drdata
);


  logic [31:0] dmem [0:127];

  assign drdata = dmem[daddr[31:2]];


  always_ff @(posedge clk) begin
    if (dwe) begin
      case (itype)
        3'b000 : begin // SB (Store Byte: 8-bit)
          case (daddr[1:0])
            2'b00 : dmem[daddr[31:2]][ 7: 0] <= dwdata[7:0];
            2'b01 : dmem[daddr[31:2]][15: 8] <= dwdata[7:0];
            2'b10 : dmem[daddr[31:2]][23:16] <= dwdata[7:0];
            2'b11 : dmem[daddr[31:2]][31:24] <= dwdata[7:0];
          endcase
        end
        3'b001 : begin // SH (Store Halfword: 16-bit)
          case (daddr[1])
            1'b0  : dmem[daddr[31:2]][15: 0] <= dwdata[15:0];
            1'b1  : dmem[daddr[31:2]][31:16] <= dwdata[15:0];
          endcase
        end
        3'b010 : begin // SW (Store Word: 32-bit)
          dmem[daddr[31:2]] <= dwdata;
        end
      endcase
    end
  end

endmodule
