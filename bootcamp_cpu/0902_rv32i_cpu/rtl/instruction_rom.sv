module instruction_rom (
  input   logic [31:0] instr_addr,
  output  logic [31:0] instr_code
);

  logic [31:0] instr_rom [0:15];

  initial begin
    //R - type
    instr_rom[ 0] = 32'h0041_82b3; //add x5, x3, x4
    /*instr_rom[ 1] = 32'h0053_2323;
    instr_rom[ 2] = 32'h0053_2323;
    instr_rom[ 3] = 32'h0053_2323;
    instr_rom[ 4] = 32'h0053_2323;
    instr_rom[ 5] = 32'h0053_2323;
    instr_rom[ 6] = 32'h0053_2323;
    instr_rom[ 7] = 32'h0053_2323;
    instr_rom[ 8] = 32'h0053_2323;
    instr_rom[10] = 32'h0053_2323;*/
    //S - type
    instr_rom[1] = 32'h0053_2323; //sw x6, x3, 6(x6)
    //I - type
    instr_rom[2] = 32'h0023_8413; //addi x8, x7, 2
    //IL- type
    instr_rom[3] = 32'h0063_2503; //iw  x10, 6(x6)
  end

  assign instr_code = instr_rom[instr_addr[5:2]];

endmodule
