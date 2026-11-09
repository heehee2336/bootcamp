`include "uvm_macros.svh"
import uvm_pkg::*;

interface fifo_if(input logic clk, input logic rst_n);
  logic        push;
  logic        pop;
  logic [7:0] wdata;
  logic [7:0] rdata;
  logic        full;
  logic        empty;

  clocking drv_cb @(posedge clk);
    default input #1step output #1;
    output wdata;
    output push;
    output pop;
  endclocking

  clocking mon_cb @(posedge clk);
    default input #1step;
    input full;
    input empty;
    input rdata;
    input wdata;
    input push;
    input pop;
  endclocking

  modport drv_mb (clocking drv_cb, input clk);
  modport mon_mb (clocking mon_cb, input clk);

endinterface

class fifo_seq_item extends uvm_sequence_item;
  rand bit push;
  rand bit pop;
  rand logic [7:0] wdata;
  bit full, empty;
  logic [7:0] rdata;

  constraint c_op {
    push dist {0 := 20, 1 := 80};
    pop  dist {0 := 50, 1 := 50};
  }

  `uvm_object_utils_begin(fifo_seq_item)
    `uvm_field_int(push, UVM_DEFAULT)
    `uvm_field_int(pop, UVM_DEFAULT)
    `uvm_field_int(wdata, UVM_DEFAULT)
    `uvm_field_int(full, UVM_DEFAULT)
    `uvm_field_int(empty, UVM_DEFAULT)
    `uvm_field_int(rdata, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name = "fifo_seq_item");
    super.new(name);
  endfunction

  function string convert2string();
    return $sformatf("push = %d, pop = %d, wdata = %0h, rdata = %0h", push, pop, wdata, rdata);
  endfunction
endclass

class fifo_sequence extends uvm_sequence #(fifo_seq_item);
  `uvm_object_utils(fifo_sequence)

  function new(string name = "fifo_seq");
    super.new(name);
  endfunction

  virtual task body();
    fifo_seq_item f_item;

     // 1. overflow
    // push = 1 * 16 -> made full state
    repeat(16) begin
      f_item = fifo_seq_item::type_id::create("f_item");
      start_item(f_item);
        if (!f_item.randomize() with {push == 1; pop == 0;})
        `uvm_fatal("SQE", "push * 16 : randomize fail")
      finish_item(f_item);
    end
    // full state, push = 1
    repeat(3) begin
      f_item = fifo_seq_item::type_id::create("f_item");
      start_item(f_item);
        if (!f_item.randomize() with {push == 1; pop == 0;})
        `uvm_fatal("SQE", "overflow, push * 3 : randomize fail")
      finish_item(f_item);    
    end
    
    // 2. underflow
    repeat(16) begin
      f_item = fifo_seq_item::type_id::create("f_item");
      start_item(f_item);
       if (!f_item.randomize() with {push == 0; pop == 1;})
        `uvm_fatal("SQE", "pop * 16 : randomize fail")
      finish_item(f_item);
    end
    // empty state, pop = 1
    repeat(3) begin
      f_item = fifo_seq_item::type_id::create("f_item");
      start_item(f_item);
       if (!f_item.randomize() with {push == 0; pop == 1;})
        `uvm_fatal("SQE", "underflow, pop * 3 : randomize fail")
      finish_item(f_item);
    end

    // 3. vaild 
    repeat(5000) begin
      f_item = fifo_seq_item::type_id::create("f_item");
      start_item(f_item);
      if(!f_item.randomize())
        `uvm_fatal("SEQ", "randomize FAIL")
      finish_item(f_item);

    // 4. push & pop 
      repeat(3) begin
      f_item = fifo_seq_item::type_id::create("f_item");
      start_item(f_item);
      if(!f_item.randomize() with {push == 1 ; pop == 1;})
        `uvm_fatal("SEQ", "fail push & pop")
      finish_item(f_item);
    end
    end
  endtask
endclass

class fifo_driver extends uvm_driver #(fifo_seq_item);
  `uvm_component_utils(fifo_driver)
  virtual fifo_if f_if;

  function new(string name = "fifo_drv", uvm_component c = null);
    super.new(name, c);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_if)::get(this, "", "f_if", f_if))
      `uvm_fatal("DRV", "can't access virtual interface")
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    f_if.push <= 1'b0;
    f_if.pop  <= 1'b0;
    f_if.wdata <= 16'h0;
    `uvm_info("DRV", $sformatf("driving time : %t", $time), UVM_HIGH)
    wait(!f_if.rst_n);
    wait(f_if.rst_n);

    forever begin
      seq_item_port.get_next_item(req);
      @(posedge f_if.clk);
      f_if.push <= req.push;
      f_if.pop  <= req.pop;
      if(req.push) begin
        f_if.wdata <= req.wdata;
      end else begin
        f_if.wdata <= 16'hx;
      end
      seq_item_port.item_done();
    end
  endtask
endclass

class fifo_monitor extends uvm_monitor;
  `uvm_component_utils(fifo_monitor)
  virtual fifo_if f_if;
  uvm_analysis_port #(fifo_seq_item) send;

  function new(string name = "fifo_mon", uvm_component c = null);
    super.new(name, c);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_if)::get(this, "", "f_if", f_if))
      `uvm_fatal("MON", "can't access virtual interface")
    send = new("send", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      @(posedge f_if.clk);
      #1;
      if (f_if.push || f_if.pop) begin
        fifo_seq_item item = fifo_seq_item::type_id::create("item");
        item.push  = f_if.push;
        item.pop   = f_if.pop;
        item.wdata = f_if.wdata;
        item.rdata = f_if.rdata;
        `uvm_info("MON", $sformatf("monitoring time : %t", $time), UVM_HIGH)
        send.write(item);
      end
    end
  endtask
endclass

class fifo_agent extends uvm_agent;
  `uvm_component_utils(fifo_agent)
  fifo_driver fifo_drv;
  fifo_monitor fifo_mon;
  uvm_sequencer #(fifo_seq_item) fifo_sqr;

  function new(string name = "fifo_agt", uvm_component c = null);
    super.new(name, c);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    fifo_drv = fifo_driver::type_id::create("fifo_drv", this);
    fifo_mon = fifo_monitor::type_id::create("fifo_mon", this);
    fifo_sqr = uvm_sequencer #(fifo_seq_item)::type_id::create("fifo_sqr", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    fifo_drv.seq_item_port.connect(fifo_sqr.seq_item_export);
  endfunction
endclass

class fifo_coverage extends uvm_subscriber #(fifo_seq_item);
  `uvm_component_utils(fifo_coverage)
  fifo_seq_item f_item;
  virtual fifo_if f_if;
  
  logic [7:0] fifo_reg [$];
    bit is_full;
    bit is_empty;
    bit do_overflow;
    bit do_underflow;
    bit do_valid;

  covergroup fifo_cg;
    option.per_instance = 1;

    cp_push     : coverpoint f_item.push {
      bins push_0 = {0};
      bins push_1 = {1};
    }
    cp_pop      : coverpoint f_item.pop {
      bins pop_0 = {0};
      bins pop_1 = {1};
    }
    cp_full     : coverpoint f_item.full {
      bins full_0 = {0};
      bins full_1 = {1};
    }
    cp_empty    : coverpoint f_item.empty {
      bins empty_0 = {0};
      bins empty_1 = {1};
    }

    cp_overflow  : coverpoint do_overflow { 
      bins off  = {0}; 
      bins on   = {1}; 
    }

    cp_underflow : coverpoint do_underflow { 
      bins off  = {0}; 
      bins on   = {1}; 
    }

    cp_valid     : coverpoint do_valid {
      bins off  = {0}; 
      bins on   = {1}; 
     }
    
    cp_rst_n     : coverpoint f_if.rst_n {
      bins active   = {1};
      bins active_n = {0};
      bins tr_active     = (0 => 1);
    }

    cp_count     : coverpoint fifo_reg.size(){
      bins empty        = {0};
      bins almost_empty = {1};
      bins valid        = {[2:6]};
      bins almost_full  = {7};
      bins full         = {8};
    }


    cross_full_case: cross cp_push, cp_pop, cp_full, cp_empty, cp_overflow, cp_underflow, cp_valid {
      ignore_bins impossible_state = binsof(cp_full.full_1) && binsof(cp_empty.empty_1);
      ignore_bins invalid_overflow  = binsof(cp_overflow.on) && !binsof(cp_full.full_1);
      ignore_bins invalid_underflow = binsof(cp_underflow.on) && !binsof(cp_empty.empty_1);
      ignore_bins invalid_pop_empty = binsof(cp_empty.empty_1) && binsof(cp_pop.pop_1) && binsof(cp_valid.on);
    }

    cross_rst_case: cross cp_rst_n, cp_full, cp_empty {
      ignore_bins impossible_rst_full_empty = binsof(cp_full.full_1) && binsof(cp_empty.empty_1) && binsof(cp_rst_n.active);
    }

    //cross_op: cross cp_push, cp_pop;
    //cross_state: cross cp_push, cp_pop, cp_full, cp_empty{
     // ignore_bins impossible_state = binsof(cp_full.full_1) && binsof(cp_empty.empty_1);
    //ignore bins impossible_state = cross_state with (cp_full == 1 &&
    //cp_empty == 1);}

  endgroup

  function new(string name = "fifo_cov", uvm_component c = null);
    super.new(name, c);
    fifo_cg = new();
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db #(virtual fifo_if)::get(this,"","f_if",f_if)) begin
    `uvm_fatal("COV","Not Setting Virtual interface!")
   end
  endfunction
  virtual function void write(fifo_seq_item t);
    bit rst_n;
    f_item = t;
    fifo_cg.sample();
    
    rst_n  = f_if.rst_n;

    is_full       = (fifo_reg.size() == 8);
    is_empty      = (fifo_reg.size() == 0);
    do_overflow   = is_full && f_item.push;
    do_underflow  = is_empty && f_item.pop;
    do_valid      = (fifo_reg.size() > 0);

    if (!rst_n) begin
      fifo_reg.delete();
    end else begin
      if (f_item.push && !is_full) 
        fifo_reg.push_back(f_item.wdata);
      if (f_item.pop && !is_empty)
        void'(fifo_reg.pop_front());
    end
  endfunction

  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("COV", $sformatf("Functional Coverage = %0.2f%%", fifo_cg.get_inst_coverage()), UVM_NONE)
  endfunction
endclass

class fifo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fifo_scoreboard)
  uvm_analysis_imp #(fifo_seq_item, fifo_scoreboard) recv;
  int pass_cnt = 0, fail_cnt = 0;
  logic [7:0] fifo_reg [$];
  virtual fifo_if f_if;

  function new(string name = "fifo_scd", uvm_component c = null);
    super.new(name, c);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    recv = new("recv", this);

    if(!uvm_config_db #(virtual fifo_if)::get(this,"","f_if",f_if)) begin
      `uvm_fatal("SCB", "Not setting virtual interface!")
    end
  endfunction

  virtual function void write(fifo_seq_item f_item);

    bit is_full;
    bit is_empty;
    bit do_push;
    bit do_pop;
    
    if (!f_if.rst_n) begin
      fifo_reg.delete();
      return;
    end

   `uvm_info("SCB_DEBUG", $sformatf("Time = %0t , push =%0d , wdata = %0h, rdata = %0h, q_size =%0d", $time, f_item.push, f_item.wdata, f_item.rdata, fifo_reg.size()), UVM_LOW)

    is_full  = (fifo_reg.size() == 8);
    is_empty = (fifo_reg.size() == 0);
    do_push = f_item.push && !f_item.full;
    do_pop  = f_item.pop  && !f_item.empty;

    if (do_pop) begin
      logic [7:0] exp_data = fifo_reg.pop_front();
      if(exp_data == f_item.rdata) begin
        `uvm_info("SCB", $sformatf("PASS: exp_data = %0h, rdata = %0h", exp_data, f_item.rdata), UVM_LOW)
        pass_cnt++;
      end else begin
        `uvm_info("SCB", $sformatf("FAIL: exp_data = %0h, rdata = %0h", exp_data, f_item.rdata), UVM_LOW)
        fail_cnt++;
      end
    end

    if (do_push) begin
      fifo_reg.push_back(f_item.wdata);
    end

    if (is_full||is_empty) begin
      if(is_full != f_item.full || is_empty != f_item.empty) begin
        `uvm_error("SCB_SYNC_ERROR", $sformatf("State Mismatch! time = %0t , SCB(full = %0d, empty = %0d) vs RTL(full = %0d, empty = %0d)", $time, is_full, is_empty, f_item.full, f_item.empty))
      end
    end
  endfunction

  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("SCB", "\n========================================", UVM_NONE)
    `uvm_info("SCB", $sformatf("pass: %0d / error : %0d", pass_cnt, fail_cnt), UVM_NONE)
    if (fail_cnt == 0 && pass_cnt > 0)
      `uvm_info("SCB", "TEST PASSED", UVM_NONE)
    else
      `uvm_error("SCB", "TEST FAILED")
    `uvm_info("SCB", "\n========================================", UVM_NONE)
  endfunction
endclass

class fifo_environment extends uvm_env;
  `uvm_component_utils(fifo_environment)
  fifo_agent fifo_agt;
  fifo_scoreboard fifo_scb;
  fifo_coverage fifo_cov; 

  function new(string name = "fifo_env", uvm_component c = null);
    super.new(name, c);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    fifo_agt = fifo_agent::type_id::create("fifo_agt", this);
    fifo_scb = fifo_scoreboard::type_id::create("fifo_scb", this);
    fifo_cov = fifo_coverage::type_id::create("fifo_cov", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    fifo_agt.fifo_mon.send.connect(fifo_scb.recv);
    fifo_agt.fifo_mon.send.connect(fifo_cov.analysis_export);
  endfunction
endclass

class fifo_test extends uvm_test;
  `uvm_component_utils(fifo_test)
  fifo_environment fifo_env;

  function new(string name = "fifo_test", uvm_component c = null);
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


module tb_fifo_uvm();
  logic clk = 0;
  logic rst_n = 0;

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
    uvm_config_db #(virtual fifo_if)::set(null, "*", "f_if", f_if);
    run_test("fifo_test");
  end
endmodule

