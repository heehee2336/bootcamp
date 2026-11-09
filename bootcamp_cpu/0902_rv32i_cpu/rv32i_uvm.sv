`include "uvm_macros.svh"
import uvm_pkg::*;

interface cpu_if(input logic clk);
    logic rst_n;

    clocking drv_cb @(posedge clk);
        default input #1step output #1;
        output rst_n;
    endclocking
endinterface

interface probe_if(
    input logic clk,
    input logic [31:0] pc,
    input logic [31:0] reg_a0
);
    clocking mon_cb @(posedge clk);
        default input #1step output #1;
        input pc;
        input reg_a0;
    endclocking
endinterface


class cpu_txn extends uvm_sequence_item;
    logic [31:0] pc;
    logic [31:0] reg_a0;
    
    `uvm_object_utils(cpu_txn)
    
    function new(string name = "cpu_txn");
        super.new(name);
    endfunction
endclass

class cpu_seq extends uvm_sequence #(cpu_txn);
    `uvm_object_utils(cpu_seq)
    
    function new(string name = "cpu_seq");
        super.new(name);
    endfunction
    
    task body();
        req = cpu_txn::type_id::create("req");
        start_item(req);
        finish_item(req);
    endtask
endclass

class cpu_driver extends uvm_driver #(cpu_txn);
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
        cpu_if_inst.rst_n = 0;
        repeat(10) @(cpu_if_inst.drv_cb);
        cpu_if_inst.drv_cb.rst_n <= 1;
    endtask
endclass

class cpu_monitor extends uvm_monitor;
    virtual probe_if p_vif;
    uvm_analysis_port #(cpu_txn) send;
    
    `uvm_component_utils(cpu_monitor)
    
    function new(string name, uvm_component c = null);
        super.new(name, c);
        send = new("send", this);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(virtual probe_if)::get(this, "", "p_vif", p_vif);
    endfunction
    
    task run_phase(uvm_phase phase);
        cpu_txn txn;
        forever begin
            @(p_vif.mon_cb);
            txn = cpu_txn::type_id::create("txn");
            txn.pc = p_vif.mon_cb.pc;
            txn.reg_a0 = p_vif.mon_cb.reg_a0;
            send.write(txn);
        end
    endtask
endclass

class cpu_scoreboard extends uvm_scoreboard;
    uvm_analysis_imp #(cpu_txn, cpu_scoreboard) recv;
    logic [31:0] halt_pc = 32'h0000004C; 
    
    `uvm_component_utils(cpu_scoreboard)
    
    function new(string name, uvm_component c = null);
        super.new(name, c);
        recv = new("recv", this);
    endfunction
    
    function void write(cpu_txn txn);
        if (txn.pc == halt_pc) begin
            if (txn.reg_a0 == 32'd55) begin
                `uvm_info("SCOREBOARD", "TEST PASSED", UVM_NONE)
            end else begin
                `uvm_error("SCOREBOARD", "TEST FAILED")
            end
        end
    endfunction
endclass

class cpu_agent extends uvm_agent;
    cpu_driver drv;
    cpu_monitor mon;
    uvm_sequencer #(cpu_txn) sqr;
    
    `uvm_component_utils(cpu_agent)
    
    function new(string name, uvm_component c = null);
        super.new(name, c);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        drv = cpu_driver::type_id::create("drv", this);
        mon = cpu_monitor::type_id::create("mon", this);
        sqr = uvm_sequencer#(cpu_txn)::type_id::create("sqr", this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction
endclass

class cpu_env extends uvm_env;
    cpu_agent agent;
    cpu_scoreboard scb;
    
    `uvm_component_utils(cpu_env)
    
    function new(string name, uvm_component c = null);
        super.new(name, c);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = cpu_agent::type_id::create("agent", this);
        scb = cpu_scoreboard::type_id::create("scb", this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agent.mon.send.connect(scb.recv);
    endfunction
endclass

class cpu_test extends uvm_test;
    cpu_env env;
    
    `uvm_component_utils(cpu_test)
    
    function new(string name, uvm_component c = null);
        super.new(name, c);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = cpu_env::type_id::create("env", this);
    endfunction
    
    task run_phase(uvm_phase phase);
        cpu_seq seq;
        phase.raise_objection(this);
        seq = cpu_seq::type_id::create("seq");
        seq.start(env.agent.sqr);
        #50000;
        phase.drop_objection(this);
    endtask
endclass

module tb_top;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    logic clk;

    cpu_if cpu_if_inst(clk);

    rv32i_top DUT (
        .clk(clk),
        .rst_n(cpu_if_inst.rst_n)
    );

    bind rv32i_cpu probe_if p_if (
        .clk(clk),
        .pc(U_DATAPATH.pc),
        .reg_a0(U_DATAPATH.register_file[10])
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        uvm_config_db#(virtual cpu_if)::set(null, "*", "cpu_if_inst", cpu_if_inst);
        uvm_config_db#(virtual probe_if)::set(null, "*", "p_vif", DUT.U_RV32I_CPU.p_if);
        run_test("cpu_test");
    end
endmodule
