module rv32i_top (
  input logic clk,
  input logic rst_n
);

  // Instruction Memory 인터페이스 신호
  logic [31:0] instr_addr;
  logic [31:0] instr_code;

  // Data Memory 인터페이스 신호
  logic [31:0] daddr;
  logic [31:0] dwdata;
  logic [31:0] drdata;
  logic        dwe;
  logic [ 2:0] itype;

  // RV32I Core
  rv32i_cpu U_RV32I_CPU (
    .*
  );

  // Instruction Memory (ROM)
  instruction_rom U_ROM (
    .*
  );

  // Data Memory (RAM)
  data_mem U_DATA_MEM (
    .*
  );

endmodule

module rv32i_cpu (
  input  logic        clk,
  input  logic        rst_n,
  input  logic [31:0] instr_code,
  input  logic [31:0] drdata,
  output logic [31:0] instr_addr,
  output logic [31:0] daddr,
  output logic [31:0] dwdata,
  output logic        dwe,
  output logic [ 2:0] itype
);

  // Control Unit <-> Datapath 연결용 제어 신호들
  logic        rf_we;
  logic        alusrc_sel;
  logic [ 3:0] alu_control;
  logic [ 2:0] rfsrc_sel;
  logic        branch;
  logic        jal;
  logic        jalr;
  logic        pc_en;

  // 제어 유닛 (Control Unit)
  control_unit U_CONTROL_UNIT (
    .*
  );

  // 데이터패스 (Datapath)
  datapath U_DATAPATH(
    .*
  );

endmodule
