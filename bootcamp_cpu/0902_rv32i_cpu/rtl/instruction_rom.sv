/* module instruction_rom (
  input   logic [31:0] instr_addr,
  output  logic [31:0] instr_code
);

  logic [31:0] instr_rom [0:127];

   `ifdef SIMULATION
  initial begin
   //R - type
    instr_rom[0] = 32'h0041_82b3; //add x5, x3, x4
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
    //instr_rom[1] = 32'h0053_2323; //sw x6, x3, 6(x6)
    //I - type
    //instr_rom[2] = 32'h0023_8413; //addi x8, x7, 2
    //IL- type
    //instr_rom[3] = 32'h0063_2503; //iw  x10, 6(x6)
    //B - type
    //instr_rom[4] = 32'hfe62_8ce3; // beq x5, x6, -8
    //instr_rom[5] = 32'hfe62_9ce3; // bne x5, x6, -8
  //end

    //initial
      //$readmemh("./rtl/rom_code_ex1.mem", instr_rom,0,18);

  //`endif

  //assign instr_code = instr_rom[instr_addr[31:2]];

//e:wq
//ndmodule*/
module instruction_rom (
  input   logic [31:0] instr_addr,
  output  logic [31:0] instr_code
);

  logic [31:0] instr_rom [0:127];

   `ifdef SIMULATION
    initial begin
    // ==========================================
    // R-Type Instructions
    // ==========================================
    instr_rom[0]  = 32'h004182b3; // add x5, x3, x4  (x5 = x3 + x4)
    instr_rom[1]  = 32'h404182b3; // sub x5, x3, x4  (x5 = x3 - x4)
    instr_rom[2]  = 32'h004192b3; // sll x5, x3, x4  (x5 = x3 << x4)
    instr_rom[3]  = 32'h0041a2b3; // slt x5, x3, x4  (x5 = (x3 < x4) ? 1 : 0)
    instr_rom[4]  = 32'h0041c2b3; // xor x5, x3, x4  (x5 = x3 ^ x4)
    instr_rom[5]  = 32'h0041d2b3; // srl x5, x3, x4  (x5 = x3 >> x4, logical)
    instr_rom[6]  = 32'h4041d2b3; // sra x5, x3, x4  (x5 = x3 >>> x4, arithmetic)
    instr_rom[7]  = 32'h0041e2b3; // or  x5, x3, x4  (x5 = x3 | x4)
    instr_rom[8]  = 32'h0041f2b3; // and x5, x3, x4  (x5 = x3 & x4)

    // ==========================================
    // I-Type Instructions (Arithmetic & Loads)
    // ==========================================
    instr_rom[9]  = 32'h004182d3; // addi x5, x3, 4  (x5 = x3 + 4)
    instr_rom[10] = 32'h0041a2d3; // slti x5, x3, 4  (x5 = (x3 < 4) ? 1 : 0)
    instr_rom[11] = 32'h0041c2d3; // xori x5, x3, 4  (x5 = x3 ^ 4)
    instr_rom[12] = 32'h0041e2d3; // ori  x5, x3, 4  (x5 = x3 | 4)
    instr_rom[13] = 32'h0041f2d3; // andi x5, x3, 4  (x5 = x3 & 4)
    instr_rom[14] = 32'h004192d3; // slli x5, x3, 4  (x5 = x3 << 4)
    instr_rom[15] = 32'h0041d2d3; // srli x5, x3, 4  (x5 = x3 >> 4, logical)
    instr_rom[16] = 32'h4041d2d3; // srai x5, x3, 4  (x5 = x3 >>> 4, arithmetic)
    instr_rom[17] = 32'h00418283; // lw   x5, 4(x3)  (x5 = Memory[x3 + 4])

    // ==========================================
    // S-Type Instructions (Stores)
    // ==========================================
    instr_rom[18] = 32'h00518223; // sw   x5, 4(x3)  (Memory[x3 + 4] = x5)
    instr_rom[19] = 32'h00518123; // sh   x5, 2(x3)  (Memory[x3 + 2] = x5[15:0])
    instr_rom[20] = 32'h005180a3; // sb   x5, 1(x3)  (Memory[x3 + 1] = x5[7:0])

    //IL- type
    //instr_rom[3] = 32'h0063_2503; //iw  x10, 6(x6)
    //B - type
    //instr_rom[4] = 32'hfe62_8ce3; // beq x5, x6, -8
    //instr_rom[5] = 32'hfe62_9ce3; // bne x5, x6, -8
  end

    initial
