`include "uvm_macros.svh"
import uvm_pkg ::*;

interface fifo_if(input logic clk, input logic rst_n);
  logic push;
  logic pop;
  logic [15:0] wdata;

  logic [15:0] rdata;
  logic full, empty;

endinterface

class fifo_seq_item extends uvm_sequence_item;
       logic        push, pop;
  rand logic [15:0] wdata;
       logic        full,empty;
       logic [15:0] rdata;

  /*constraint c_operation {
    push dist {0 := 50, 1 := 50};
    pop  dist {0 := 50, 1 := 50};
  }*/

  `uvm_object_utils_begin(fifo_seq_item)
    `uvm_field_int(push,UVM_DEFAULT)
    `uvm_field_int(pop,UVM_DEFAULT)
    `uvm_field_int(wdata,UVM_DEFAULT)
    `uvm_field_int(full,UVM_DEFAULT)
    `uvm_field_int(empty,UVM_DEFAULT)
    `uvm_field_int(rdata,UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name = "fifo_seq_item");
    super.new(name);
  endfunction

  function string convert2string();
    return $sformatf("push = %d, pop = %d, wdata = %d", push, pop, wdata);
  endfunction

endclass

//sequence
class fifo_sequence extends uvm_sequence #(fifo_seq_item);
  `uvm_object_utils(fifo_sequence)

  function new(string name = "fifo_seq");
    super.new(name);
  endfunction

  virtual task body();
    fifo_seq_item f_item;
    // write, push = 1
    repeat(16) begin
      f_item = fifo_seq_item::type_id::create("fifo_seq_item");
      start_item(f_item);
        assert(f_item.randomize());
        f_item.push = 1'b1;
        f_item.pop  = 1'b0;
        if(!f_item.randomize())
          `uvm_fatal("fifo_seq_item", "randomize FAIL")
      finish_item(f_item);
    `uvm_info("fifo_seq : push", f_item.convert2string(), UVM_HIGH)
    end

    repeat(16) begin
      f_item = fifo_seq_item::type_id::create("fifo_seq_item");
      start_item(f_item);
      f_item.push = 1'b0;
      f_item.pop  = 1'b1;
      finish_item(f_item);
    `uvm_info("fifo_seq : pop", f_item.convert2string(), UVM_HIGH)
    end
  endtask
endclass

// driver
class fifo_driver extends uvm_driver #(fifo_seq_item);
  `uvm_component_utils(fifo_driver)
  virtual fifo_if f_if;

  function new(string name = "fifo_drv", uvm_component c = null);
    super.new(name,c);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_if)::get(this,"","f_if",f_if))
      `uvm_fatal("DRV","build_phase : can't access virtual interface")
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    f_if.push <= 1'b0;
    f_if.pop  <= 1'b0;
    f_if.wdata <= 16'h0;
    wait(!f_if.rst_n);
    wait(f_if.rst_n);

    forever begin
      seq_item_port.get_next_item(req);

      @(posedge f_if.clk);
      f_if.push <= req.push;
      f_if.pop  <= req.pop;

      // push = 1, wdata
      if(req.push) begin
        f_if.wdata <= req.wdata;
      end else begin
          req.wdata <= 16'hx;
      end

    seq_item_port.item_done();

    @(posedge f_if.clk);
    f_if.push <= 1'b0;
    f_if.pop  <= 1'b0;
    f_if.wdata <= 16'hx;

    end
  endtask
endclass

// monitor
class fifo_monitor extends uvm_monitor;
  `uvm_component_utils(fifo_monitor)

  virtual fifo_if f_if;
  uvm_analysis_port #(fifo_seq_item) send;
  fifo_seq_item f_item;

  function new(string name = "fifo_drv", uvm_component c = null);
    super.new(name,c);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_if)::get(this,"","f_if",f_if))
      `uvm_fatal("MON","build_phase : can't access virtual interface")
      send = new("WRITE", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      @(posedge f_if.clk);

      // Push (0 Cycle Delay)
      if (f_if.push) begin
        fifo_seq_item push_item = fifo_seq_item::type_id::create("push_item");
        push_item.push  = 1'b1;
        push_item.wdata = f_if.wdata;
        send.write(push_item);
      end

      // Pop
      if (f_if.pop) begin
        fifo_seq_item pop_item = fifo_seq_item::type_id::create("pop_item");
        pop_item.pop = 1'b1;
        pop_item.rdata = f_if.rdata;
        send.write(pop_item);
      end
    end
  endtask
endclass

// agent
class fifo_agent extends uvm_agent;
  `uvm_component_utils(fifo_agent)
  fifo_driver                    fifo_drv;
  fifo_monitor                   fifo_mon;
  uvm_sequencer#(fifo_seq_item)  fifo_sqr;

  function new(string name = "ram_agt", uvm_component c = null);
    super.new(name,c);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    fifo_drv = fifo_driver::type_id::create("fifo_drv", this);
    fifo_mon = fifo_monitor::type_id::create("fifo_mon", this);
    fifo_sqr = uvm_sequencer#(fifo_seq_item) ::type_id::create("sqr", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    fifo_drv.seq_item_port.connect(fifo_sqr.seq_item_export);
  endfunction
endclass

// coverage
class fifo_coverage extends uvm_subscriber #(fifo_seq_item);
  `uvm_component_utils(fifo_coverage)
  fifo_seq_item item;

  covergroup fifo_cg;
    option.per_instance = 1;

    cp_push: coverpoint item.push {
      bins push_0 = {0};
      bins push_1 = {1};
    }
    cp_pop: coverpoint item.pop {
      bins pop_0 = {0};
      bins pop_1 = {1};
    }
    cp_full: coverpoint item.full {
      bins full_0 = {0};
      bins full_1 = {1};
    }
    cp_empty: coverpoint item.empty {
      bins empty_0 = {0};
      bins empty_1 = {1};
    }

    cross_op: cross cp_push, cp_pop;
    cross_state: cross cp_push, cp_pop, cp_full, cp_empty;
  endgroup

  function new(string name = "fifo_cov", uvm_component c = null);
    super.new(name, c);
    fifo_cg = new();
  endfunction

  virtual function void write(fifo_seq_item t);
    item = t;
    fifo_cg.sample();
  endfunction

  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("COV", $sformatf("Functional Coverage = %0.2f%%", fifo_cg.get_inst_coverage()), UVM_NONE)
  endfunction
endclass

// scoreboard
class fifo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fifo_scoreboard)
  uvm_analysis_imp #(fifo_seq_item, fifo_scoreboard) recv;
  int pass_cnt = 0, fail_cnt = 0;
  logic [15:0] fifo_reg [$];

  function new(string name = "fifo_scd", uvm_component c = null);
    super.new(name,c);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    recv = new("READ",this);
  endfunction

  virtual function void write(fifo_seq_item f_item);
    // push
    if(f_item.push) begin
      fifo_reg.push_back(f_item.wdata);
      `uvm_info("SCB", $sformatf("Pass : saving %0h into fifo_reg", f_item.wdata), UVM_HIGH);
    end

    // pop
    if (f_item.pop) begin
      if(fifo_reg.size() == 0) begin
        `uvm_error("SCB","error : fifo_reg is empty")
        fail_cnt ++;
      end else begin
        logic [15:0] exp_data = fifo_reg.pop_front();

        if(exp_data == f_item.rdata) begin
          `uvm_info("SCB",$sformatf("PASS : exp_data =%0h, fifo_rdata = %0h", exp_data, f_item.rdata), UVM_HIGH)
          pass_cnt ++;
        end else begin
          `uvm_info("SCB",$sformatf("FAIL : exp_data =%0h, fifo_rdata = %0h", exp_data, f_item.rdata), UVM_HIGH)
          fail_cnt ++;
        end
      end
    end
  endfunction

  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("SCB",$sformatf("\n========================================"), UVM_NONE)
    `uvm_info("SCB", $sformatf("\npass:  %0d / error : %0d", pass_cnt, fail_cnt), UVM_NONE)
    if (fail_cnt == 0 && pass_cnt == 16)
      `uvm_info("SCB",$sformatf("\nTEST PASSE"), UVM_NONE)
    else
      `uvm_error("SCB",$sformatf("\nTEST FAILE"))
    `uvm_info("SCB",$sformatf("\n========================================"), UVM_NONE)
  endfunction
endclass


// environment 
class fifo_environment extends uvm_env;
  `uvm_component_utils(fifo_environment)

  fifo_agent      fifo_agt;
  fifo_scoreboard fifo_scb;
  fifo_coverage   fifo_cov;
  function new(string name = "fifo_env", uvm_component c = null);
    super.new(name,c);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    fifo_agt = fifo_agent::type_id::create("fifo_agt",this);
    fifo_scb = fifo_scoreboard::type_id::create("fifo_scb",this);
    fifo_cov = fifo_coverage::type_id::create("fifo_cov",this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    fifo_agt.fifo_mon.send.connect(fifo_scb.recv);
    fifo_agt.fifo_mon.send.connect(fifo_cov.analysis_export);
  endfunction

endclass

// test
class fifo_test extends uvm_test;
  `uvm_component_utils(fifo_test)

  fifo_environment fifo_env;

  function new(string name, uvm_component c = null);
    super.new(name, c);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    fifo_env = fifo_environment::type_id::create("fifo_env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    fifo_sequence fifo_seq;
    fifo_seq = fifo_sequence::type_id::create("fifo_seq");

    phase.raise_objection(this);
    phase.phase_done.set_drain_time(this, 50ns);
    fifo_seq.start(fifo_env.fifo_agt.fifo_sqr);
    phase.drop_objection(this);
  endtask
endclass

// tb
module tb_fifo_uvm();
  logic        clk = 0, rst_n = 0;

  always #5 clk = ~clk;

  fifo_if f_if(clk, rst_n);

  fifo_uvm dut(
    .clk(clk),
    .rst_n(rst_n),
    .wdata(f_if.wdata),
    .push(f_if.push),
    .pop(f_if.pop),
    .full(f_if.full),
    .empty(f_if.empty),
    .rdata(f_if.rdata)
  );

  initial begin
    $fsdbDumpfile("wave.fsdb");
    $fsdbDumpvars(0, tb_fifo_uvm);
  end

  initial begin
    rst_n = 0;
    #10;
    rst_n = 1; 
  end

  initial begin

    uvm_config_db #(virtual fifo_if)::set(null,"*","f_if",f_if);
    run_test("fifo_test");


  end

endmodule


