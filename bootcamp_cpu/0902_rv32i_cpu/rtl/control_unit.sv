module control_unit
  import rv32_pkg::*;
(
  input   logic [31:0] instr_code,
  output  logic        rf_we,
  output  logic        alusrc_sel,
  output  logic [ 3:0] alu_control,
  output  logic        dwe,
  output  logic [ 2:0] itype, // instruction type : funct3
  output  logic        rfsrc_sel
);

  logic [2:0] funct3;

  opcode_e opcode;
  assign opcode = opcode_e'(instr_code[6:0]);

  assign funct3 = instr_code[14:12];

  always_comb begin
    rf_we       = 1'b0;
    alusrc_sel  = 1'b0;
    alu_control = 4'b0_000;   // {funct7[5], funct3}
    dwe         = 1'b0;
    itype       = 3'b010;     // SW, LW
    rfsrc_sel   = 1'b0;
    case(opcode)
      OP_RTYPE : begin     // R - type
        rf_we       = 1'b1;
        alusrc_sel  = 1'b0;
        alu_control = {instr_code[30],instr_code[14:12]};
        dwe         = 1'b0;
        itype       = 3'b000; // SW, LW
        rfsrc_sel   = 1'b0;   // WB
      end
      OP_STYPE : begin     // S - type
        rf_we       = 1'b0;
        alusrc_sel  = 1'b1;
        alu_control = 32'd0;
        dwe         = 1'b1;
        itype       = funct3; // SW, LW
        rfsrc_sel   = 1'b0;
      end
      OP_ITYPE : begin   // I - type
        rf_we       = 1'b1;
        alusrc_sel  = 1'b1;
        if(funct3 == 3'b101)
          alu_control = {instr_code[30],funct3};
        else
          alu_control = {1'b0,funct3};
        dwe         = 1'b0;
        itype       = 3'b111;   // for : data memi
        rfsrc_sel   = 1'b0;
      end
      OP_ILTYPE : begin   // I - type
        rf_we       = 1'b1;
        alusrc_sel  = 1'b1;
        alu_control = 32'd0;
        dwe         = 1'b0;
        itype       = funct3;   // for : data memi
        rfsrc_sel   = 1'b1;
      end
    endcase
  end
endmodule
