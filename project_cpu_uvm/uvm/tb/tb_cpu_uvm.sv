`include "uvm_macros.svh"
import uvm_pkg::*;
import rv32_pkg::*; 

interface cpu_if(input logic clk);
    logic rst_n;
    logic [31:0] instr_code;

    task set_reg_file(int reg_idx, logic [31:0] val);
        if (reg_idx != 0) begin
            tb_cpu_uvm.DUT.U_RV32I_CPU.U_DATAPATH.U_REG_FILE.ram_file[reg_idx] = val;
        end
    endtask

    task wait_c_state(input logic [3:0] target_state);
        wait(tb_cpu_uvm.DUT.U_RV32I_CPU.U_CONTROL_UNIT.c_state == target_state);
    endtask

    task wait_c_state_not(input logic [3:0] target_state);
        wait(tb_cpu_uvm.DUT.U_RV32I_CPU.U_CONTROL_UNIT.c_state != target_state);
    endtask

    clocking drv_cb @(posedge clk);
        default input #1step output #1;
        output rst_n;
        output instr_code;
    endclocking
endinterface

interface cpu_probe_if(
    input logic        clk,
    input logic        rf_we,
    input logic [ 4:0] rd_addr,
    input logic [31:0] rd_data,
    input logic [31:0] rs1_data,
    input logic [31:0] rs2_data,
    input logic [31:0] imm_data,
    input logic [ 6:0] opcode,
    input logic [ 2:0] funct3,
    input logic [ 6:0] funct7
);
    clocking mon_cb @(posedge clk);
        default input #1step output #1;
        input rf_we, rd_addr, rd_data, rs1_data, rs2_data, imm_data, opcode, funct3, funct7;
    endclocking
endinterface

// seq_item
class cpu_seq_item extends uvm_sequence_item;
    rand logic [ 6:0] opcode;
    rand logic [ 2:0] funct3;
    rand logic [ 6:0] funct7;
    rand logic [ 4:0] rd, rs1, rs2;
    
    rand logic [31:0] rand_rs1_val;
    rand logic [31:0] rand_rs2_val;
    rand logic [31:0] rand_imm_val;

    logic [31:0] actual_wdata;

    `uvm_object_utils(cpu_seq_item)

    constraint c_instr_types {
        opcode inside {OP_RTYPE, OP_ITYPE}; 
        
        if (opcode == OP_RTYPE) {
            {funct7[5], funct3} inside {ADD, SUB};
            funct7[6] == 0; funct7[4:0] == 0;
        } else {
            {1'b0, funct3} inside {ADDI, ORI}; 
            funct7 == 7'b0000000;
        }
    }

    constraint c_rd_not_zero { rd != 5'd0; }

    constraint c_edge_cases {
        rand_rs1_val dist {
            32'h7FFFFFFF := 1, 
            32'h80000000 := 1, 
            32'hFFFFFFFF := 1, 
            32'h00000000 := 1, 
            [32'h00000001 : 32'h7FFFFFFE] := 2 
        };
        rand_imm_val dist {
            32'h000007FF := 1, 
            32'hFFFFF800 := 1, 
            32'h00000000 := 1  
        };
    }

    function new(string name = "cpu_seq_item");
        super.new(name);
    endfunction
endclass

// sequence
class cpu_sequence extends uvm_sequence #(cpu_seq_item);
    `uvm_object_utils(cpu_sequence)

    function new(string name = "cpu_seq");
        super.new(name);
    endfunction

    task body();
        cpu_seq_item c_item;
        repeat(200) begin
            c_item = cpu_seq_item::type_id::create("c_item");
            start_item(c_item);
            if (!c_item.randomize()) `uvm_error("SEQ", "Randomization failed")
            finish_item(c_item);
        end
    endtask
endclass

// driver
class cpu_driver extends uvm_driver #(cpu_seq_item);
    virtual cpu_if cpu_if_inst;
    
    `uvm_component_utils(cpu_driver)
    
    function new(string name, uvm_component c = null);
        super.new(name, c);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(virtual cpu_if)::get(this, "", "cpu_if_inst", cpu_if_inst);
    endfunction
    
    task run_phase(uvm_phase phase);
        logic [31:0] machine_code;
        
        cpu_if_inst.rst_n = 0;
        repeat(10) @(cpu_if_inst.drv_cb);
        cpu_if_inst.drv_cb.rst_n <= 1;

        forever begin
            seq_item_port.get_next_item(req);
            
            cpu_if_inst.set_reg_file(req.rs1, req.rand_rs1_val);
            cpu_if_inst.set_reg_file(req.rs2, req.rand_rs2_val);
            
            if (req.opcode == OP_RTYPE) begin
                machine_code = {req.funct7, req.rs2, req.rs1, req.funct3, req.rd, req.opcode};
            end else begin
                machine_code = {req.rand_imm_val[11:0], req.rs1, req.funct3, req.rd, req.opcode};
            end
            
            @(cpu_if_inst.drv_cb);
            cpu_if_inst.wait_c_state(4'd0); 
            cpu_if_inst.drv_cb.instr_code <= machine_code;
            
            @(cpu_if_inst.drv_cb);
            cpu_if_inst.wait_c_state_not(4'd0);
            cpu_if_inst.wait_c_state(4'd0);
            
            seq_item_port.item_done();
        end
    endtask
endclass

// monitor
class cpu_monitor extends uvm_monitor;
    virtual cpu_probe_if p_vif;
    uvm_analysis_port #(cpu_seq_item) send;
    
    `uvm_component_utils(cpu_monitor)
    
    function new(string name, uvm_component c = null);
        super.new(name, c);
        send = new("send", this);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(virtual cpu_probe_if)::get(this, "", "p_vif", p_vif);
    endfunction
    
    task run_phase(uvm_phase phase);
        cpu_seq_item c_item;
        forever begin
            @(p_vif.mon_cb);
            if (p_vif.mon_cb.rf_we) begin
                c_item = cpu_seq_item::type_id::create("c_item");
                c_item.opcode       = p_vif.mon_cb.opcode;
                c_item.funct3       = p_vif.mon_cb.funct3;
                c_item.funct7       = p_vif.mon_cb.funct7;
                c_item.rd           = p_vif.mon_cb.rd_addr;
                c_item.actual_wdata = p_vif.mon_cb.rd_data;
                c_item.rand_rs1_val = p_vif.mon_cb.rs1_data;
                c_item.rand_rs2_val = p_vif.mon_cb.rs2_data;
                c_item.rand_imm_val = p_vif.mon_cb.imm_data;
                send.write(c_item);
            end
        end
    endtask
endclass

// scoreboard
class cpu_scoreboard extends uvm_scoreboard;
    uvm_analysis_imp #(cpu_seq_item, cpu_scoreboard) recv;
    
    `uvm_component_utils(cpu_scoreboard)
    
    function new(string name, uvm_component c = null);
        super.new(name, c);
        recv = new("recv", this);
    endfunction
    
    function void write(cpu_seq_item c_item);
        logic [31:0] expected_wdata;
        logic [ 3:0] alu_op;
        
        alu_op = {c_item.funct7[5], c_item.funct3};
        
        if (c_item.opcode == OP_RTYPE) begin
            if (alu_op == SUB) expected_wdata = c_item.rand_rs1_val - c_item.rand_rs2_val;
            else if (alu_op == ADD) expected_wdata = c_item.rand_rs1_val + c_item.rand_rs2_val;
        end else if (c_item.opcode == OP_ITYPE) begin
            if (alu_op == ORI) expected_wdata = c_item.rand_rs1_val | c_item.rand_imm_val;
            else if (alu_op == ADDI) expected_wdata = c_item.rand_rs1_val + c_item.rand_imm_val;
        end

        if ((c_item.rand_rs1_val[31] == c_item.rand_rs2_val[31]) && (expected_wdata[31] != c_item.rand_rs1_val[31])) begin
            `uvm_info("EDGE_CASE", $sformatf("Overflow/Underflow: A:%0h, B:%0h", c_item.rand_rs1_val, c_item.rand_rs2_val), UVM_LOW)
        end

        if (expected_wdata === c_item.actual_wdata) begin
            `uvm_info("PASS", $sformatf("Match: %0h", expected_wdata), UVM_HIGH)
        end else begin
            `uvm_error("FAIL", $sformatf("Mismatch! Exp: %0h, Act: %0h", expected_wdata, c_item.actual_wdata))
        end
    endfunction
endclass

// coverage
class cpu_coverage extends uvm_subscriber #(cpu_seq_item);
    `uvm_component_utils(cpu_coverage)
    cpu_seq_item c_item;

    covergroup cg_target_inst_edge;
        cp_target_inst: coverpoint {c_item.opcode, c_item.funct7[5], c_item.funct3} {
            bins inst_add  = { {OP_RTYPE, ADD} };
            bins inst_sub  = { {OP_RTYPE, SUB} };
            bins inst_addi = { {OP_ITYPE, ADDI} };
            bins inst_ori  = { {OP_ITYPE, ORI} };
        }

        cp_operand_edge: coverpoint c_item.rand_rs1_val {
            bins max_pos = {32'h7FFFFFFF};
            bins min_neg = {32'h80000000};
            bins all_one = {32'hFFFFFFFF};
            bins zero    = {32'h00000000};
            bins others  = default;
        }

        cr_inst_vs_edge: cross cp_target_inst, cp_operand_edge;
    endgroup

    function new(string name, uvm_component c = null);
        super.new(name, c);
        cg_target_inst_edge = new();
    endfunction

    function void write(cpu_seq_item t);
        c_item = t;
        cg_target_inst_edge.sample();
    endfunction


    virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("COV", $sformatf("Functional Coverage = %0.2f%%", cg_target_inst_edge.get_inst_coverage()), UVM_NONE)
  endfunction
endclass

// agent
class cpu_agent extends uvm_agent;
    cpu_driver drv;
    cpu_monitor mon;
    uvm_sequencer #(cpu_seq_item) sqr;
    
    `uvm_component_utils(cpu_agent)
    
    function new(string name, uvm_component c = null);
        super.new(name, c);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        drv = cpu_driver::type_id::create("drv", this);
        mon = cpu_monitor::type_id::create("mon", this);
        sqr = uvm_sequencer#(cpu_seq_item)::type_id::create("sqr", this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction
endclass

// environment
class cpu_environment extends uvm_env;
    cpu_agent agent;
    cpu_scoreboard scb;
    cpu_coverage cov;
    
    `uvm_component_utils(cpu_environment)
    
    function new(string name, uvm_component c = null);
        super.new(name, c);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = cpu_agent::type_id::create("agent", this);
        scb   = cpu_scoreboard::type_id::create("scb", this);
        cov   = cpu_coverage::type_id::create("cov", this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agent.mon.send.connect(scb.recv);
        agent.mon.send.connect(cov.analysis_export);
    endfunction
endclass

// test
class cpu_test extends uvm_test;
    cpu_environment env;
    
    `uvm_component_utils(cpu_test)
    
    function new(string name, uvm_component c = null);
        super.new(name, c);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = cpu_environment::type_id::create("env", this);
    endfunction
    
    task run_phase(uvm_phase phase);
        cpu_sequence seq;
        phase.raise_objection(this);
        seq = cpu_sequence::type_id::create("seq");
        seq.start(env.agent.sqr);
        #500;
        phase.drop_objection(this);
    endtask
endclass

// tb
module tb_cpu_uvm();
    import uvm_pkg::*;
    import rv32_pkg::*;
    `include "uvm_macros.svh"

    logic clk;

    cpu_if cpu_if_inst(clk);

    rv32i_top DUT (
        .clk(clk),
        .rst_n(cpu_if_inst.rst_n)
    );

    bind rv32i_cpu cpu_probe_if p_if (
        .clk(clk),
        .rf_we(U_CONTROL_UNIT.rf_we), 
        .rd_addr(U_DATAPATH.instr_code[11:7]),
        .rd_data(U_DATAPATH.wb_muxout), 
        .rs1_data(U_DATAPATH.reg_alu_rd1), 
        .rs2_data(U_DATAPATH.reg_mux_rs2), 
        .imm_data(U_DATAPATH.reg_imm_result),  
        .opcode(U_CONTROL_UNIT.opcode),
        .funct3(U_DATAPATH.instr_code[14:12]),
        .funct7(U_DATAPATH.instr_code[31:25])
    );
    
    initial begin
      $fsdbDumpfile("wave.fsdb");
      $fsdbDumpvars(0, tb_cpu_uvm);
    end

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        uvm_config_db#(virtual cpu_if)::set(null, "*", "cpu_if_inst", cpu_if_inst);
        uvm_config_db#(virtual cpu_probe_if)::set(null, "*", "p_vif", DUT.U_RV32I_CPU.p_if);
        run_test("cpu_test");
    end
endmodule
