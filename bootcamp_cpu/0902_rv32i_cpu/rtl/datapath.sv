`define SIMULATION
import rv32_pkg::*;
module datapath (
  input   logic         clk,
  input   logic         rst_n,
  input   logic         rf_we,
  input   logic [ 2:0]  rfsrc_sel,
  input   logic         alusrc_sel,
  input   logic [ 3:0]  alu_control,
  input   logic [31:0]  instr_code,
  input   logic [31:0]  drdata,
  input   logic         jal,
  input   logic         jalr,
  input   logic         branch,
  input   logic         pc_en,
  output  logic [31:0]  instr_addr,
  output  logic [31:0]  daddr,
  output  logic [31:0]  dwdata
  );

  logic [31:0] rf_reg_rs1, rf_reg_rd2,reg_alu_rd1, reg_mux_rs2;
  logic [31:0] reg_mux_drdata,alu_reg_result, reg_imm_result;
  logic [31:0] ie_pc_imm, alusrc_muxout, wb_muxout;
  logic [31:0] add_imm, add_pc, reg_ram_out;
  logic        b_taken, reg_ram_rs2;

  assign daddr = reg_ram_out;
  assign dwdata = reg_ram_rs2;


 register U_MEM_DRATA (
    .clk(clk),
    .rst_n(rst_n),
    .data(drdata),
    .out(reg_mux_drdata)
  );

  reg_file U_REG_FILE (
    .clk(clk),
    .rst_n(rst_n),
    .ra1(instr_code[19:15]),
    .ra2(instr_code[24:20]),
    .wa (instr_code[11: 7]),
    .wd (wb_muxout),
    .we (rf_we),
    .rs1(rf_reg_rd1),
    .rs2(rf_reg_rd2)
  );

 register U__DEC_RS1 (
    .clk(clk),
    .rst_n(rst_n),
    .data(rf_reg_rd1),
    .out(reg_alu_rs1)
  );

 register U__DEC_RS2 (
    .clk(clk),
    .rst_n(rst_n),
    .data(rf_reg_rd2),
    .out(reg_mux_rs2)
  );

  imm_extend U_IMM_EXTEND (
    .instr_code(instr_code),
    .imm_extend(ie_pc_imm)
  );

 register U__DEC_IMM (
    .clk(clk),
    .rst_n(rst_n),
    .data(ie_pc_imm),
    .out(reg_imm_result)
  );

  mux_2x1 U_ALUSRC_MUX (
    .sel(alusrc_sel),
    .in0(reg_mux_rs2),
    .in1(reg_imm_result),
    .mux_out(alusrc_muxout)
  );

  alu U_ALU (
    .rs1          (reg_alu_rs1),
    .rs2          (alusrc_muxout),
    .alu_control  (alu_control),
    .alu_result   (alu_reg_result),
    .b_taken      (b_taken)
  );

 register U_EXE_ALU (
    .clk(clk),
    .rst_n(rst_n),
    .data(alu_reg_result),
    .out(reg_ram_out)
  );

 register U_EXE_RS2 (
    .clk(clk),
    .rst_n(rst_n),
    .data(reg_mux_rs2),
    .out(reg_ram_rs2)
  );

  mux_5x1 U_WB_MUX (
    .sel    (rfsrc_sel),
    .in0    (alu_reg_result),
    .in1    (reg_mux_drdata),
    .in2    (reg_imm_result),
    .in3    (add_imm),
    .in4    (add_pc),
    .mux5_out(wb_muxout)
  );

  program_counter U_PC (
    .clk        (clk),
    .rst_n      (rst_n),
    .pc_en      (pc_en),
    .rs1        (rf_reg_rs1),
    .imm_value  (ie_pc_imm),
    .b_branch   (branch),
    .b_taken    (b_taken),
    .jal        (jal),
    .jalr       (jalr),
    .pc_imm_out (add_imm),
    .pc_out     (add_pc),
    .pc         (instr_addr)
  );


endmodule

module register (
  input   logic        clk,
  input   logic        rst_n,
  input   logic [31:0] data,
  output  logic [31:0] out
);

  always_ff @(posedge clk) begin
    if(!rst_n) begin
      out <= 32'd0;
    end else out <= data;
  end

endmodule

module mux_5x1(
  input   logic [ 2:0] sel,
  input   logic [31:0] in0,
  input   logic [31:0] in1,
  input   logic [31:0] in2,
  input   logic [31:0] in3,
  input   logic [31:0] in4,
  output  logic [31:0] mux5_out
  );

  always_comb begin
    case(sel)
      3'b000 : mux5_out = in0;
      3'b001 : mux5_out = in1;
      3'b010 : mux5_out = in2;
      3'b011 : mux5_out = in3;
      3'b100 : mux5_out = in4;
    default : mux5_out = in0;
    endcase
  end
endmodule

module mux_2x1(
  input   logic        sel,
  input   logic [31:0] in0,
  input   logic [31:0] in1,
  output  logic [31:0] mux_out
);

   assign mux_out = (sel) ? in1 : in0;

endmodule

module reg_file(
  input   logic        clk,
  input   logic        rst_n,
  input   logic [ 4:0] ra1,
  input   logic [ 4:0] ra2,
  input   logic [ 4:0] wa,
  input   logic [31:0] wd,
  input   logic        we,
  output  logic [31:0] rs1,
  output  logic [31:0] rs2
  );


    logic [31:0] ram_file [0:31];

   always_ff @(posedge clk) begin
      if(!rst_n) begin
        `ifdef SIMULATION
            for (int i=1;i<32;i++)
              ram_file[i] <= i;
          `else
            for(int i=1;i<32;i++)
              ram_file[i] <= 0;
          `endif
        end else
          if(we)
            ram_file[wa] <= wd;
    end

  // read
  assign rs1 = (ra1 != 0) ? ram_file[ra1] : 32'd0;
  assign rs2 = (ra2 != 0) ? ram_file[ra2] : 32'd0;

endmodule


module alu(
  input   logic [31:0] rs1,
  input   logic [31:0] rs2,
  input   logic [ 3:0] alu_control,
  output  logic [31:0] alu_result,
  output  logic        b_taken
  );

  always_comb begin
    alu_result = 32'h0000_0000;
    b_taken = 1'b0;
    case(alu_control)
      //funct7[5],funct3}
      //R & I - type
      4'b0_000 : alu_result = rs1 + rs2; // add
      4'b1_000 : alu_result = rs1 - rs2; // sub
      4'b0_100 : alu_result = rs1 ^ rs2; // xor
      4'b0_110 : alu_result = rs1 | rs2; // or
      4'b0_111 : alu_result = rs1 & rs2; // and
      4'b0_001 : alu_result = rs1 << rs2; // sll
      4'b0_101 : alu_result = rs1 >> rs2; // srl
      4'b1_101 : alu_result = $signed(rs1) >>> rs2; // sra
      4'b0_110 : alu_result = $signed(rs1) <$signed(rs2) ? 32'd1 : 32'd0; //slt
      4'b0_111 : alu_result = (rs1 < rs2) ? 32'b1 : 32'b0; // sltu
    endcase
    //B - type
    case(alu_control)
      4'b0_000 : b_taken = ($signed(rs1) == $signed(rs2)) ? 1'b1 : 1'b0; // BEQ
      4'b0_001 : b_taken = ($signed(rs1) != $signed(rs2)) ? 1'b1 : 1'b0; // BNE
      4'b0_100 : b_taken = ($signed(rs1) < $signed(rs2)) ? 1'b1 : 1'b0; // BLT
      4'b0_101 : b_taken = ($signed(rs1) >= $signed(rs2)) ? 1'b1 : 1'b0; // BGE
      4'b0_110 : b_taken = (rs1 < rs2) ? 1'b1 : 1'b0; // BLTU
      4'b0_111 : b_taken = (rs1 >= rs2) ? 1'b1 : 1'b0; // BGEU
    endcase
  end

    // JAL
endmodule

// imm etender, L
module imm_extend
  import rv32_pkg::*;
(
  input   logic [31:0] instr_code,
  output  logic [31:0] imm_extend
);

  opcode_e opcode;

  assign opcode = opcode_e'(instr_code[6:0]); // opcode_e' : casting operator

  always_comb begin
    case(opcode)
      OP_STYPE : imm_extend = {{20{instr_code[31]}},instr_code[31:25],instr_code[11:7]};
      OP_ITYPE, OP_ILTYPE : imm_extend = {{20{instr_code[31]}},instr_code[31:20]}; 
      OP_UTYPE : imm_extend = {instr_code[31:12], 12'b0};
      OP_BTYPE : imm_extend = {{19{instr_code[31]}},instr_code[31],instr_code[7],instr_code[30:25],instr_code[11:8],1'b0};
    OP_JTYPE, OP_JLTYPE : imm_extend = {{12{instr_code[31]}},instr_code[31],instr_code[19:12],instr_code[20],instr_code[30:21], 1'b0};
      default : imm_extend = 32'h0000_0000;
    endcase
  end

endmodule

module program_counter (
  input   logic        clk,
  input   logic        rst_n,
  input   logic        pc_en,
  input   logic [31:0] rs1,
  input   logic [31:0] imm_value,
  input   logic        b_branch,
  input   logic        b_taken,
  input   logic        jal,
  input   logic        jalr,
  output  logic [31:0] pc_imm_out,
  output  logic [31:0] pc_out,
  output  logic [31:0] pc
  );

  logic [31:0] register_pc;
  logic [31:0] pc_4, pc_imm, pc_next, mux_pc, reg_pc_next;
  logic        pcsrc_sel;

  assign pc = register_pc;
  assign pcsrc_sel = (jal || jalr || (b_branch && b_taken)) ? 1'b1 : 1'b0;
  assign pc_4 = pc + 4;
  assign pc_out = pc_4;
  assign pc_imm = mux_pc + imm_value;
  assign pc_imm_out = pc_imm;

  mux_2x1 U_PC_RS1_MUX (
    .sel(jalr),
    .in0(pc),
    .in1(rs1),
    .mux_out(mux_pc)
  );

  mux_2x1 U_PC_IMM__MUX (
    .sel(pcsrc_sel),
    .in0(pc_4),
    .in1(pc_imm),
    .mux_out(pc_next)
  );


 register U_REG_EXE_PC_NEXT (
    .clk(clk),
    .rst_n(rst_n),
    .data(pc_next),
    .out(reg_pc_next)
  );

  always_ff @(posedge clk) begin
   if(!rst_n)
     register_pc <= 32'd0;
   else 
     if (pc_en)
       register_pc <= reg_pc_next;
  end

endmodule

