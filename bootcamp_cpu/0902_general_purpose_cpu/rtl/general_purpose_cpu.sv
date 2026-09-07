module general_purpose_cpu();
endmodule


module control_unit(
    input   logic       clk,
    input   logic       rst_n,
    input   logic       lt10,
    output  logic       rf_srcsel,
    output  logic [1:0] ra0,
    output  logic [1:0] ra1,
    output  logic [1:0] wa,
    output  logic [1:0] we,
    output  logic       out_control
  );

  typedef enum [2:0] {S0,S1,S2,S3,S4} state_e;
  state_e c_state, n_state;

  assign rf_srcsel = (c_state == S0 || c_state == S1 || c_state == S4 || c_state == S5) ? 1'b1 : 1'b0;
  assign we = (c_state == S3 || c_state == S6) ? 1'b0 : 1'b1;

  always_ff @(posedge clk) begin
    if(!rst_n)
      c_state <= S0;
    else c_state <= n_state;
  end

  always_comb begin
    n_state = c_state;
    case(c_state)
      S0 : begin
        ra0 = 3'b000;
        ra1 = 3'b000;
        wa  = 3'b011;
        n_state = S1;
      end
      S1 : begin
        ra0 = 3'b000;
        ra1 = 3'b000;
        wa  = 3'b010;
        n_state = S2;
      end
      S2 : begin
        ra0 = 3'b000;
        ra1 = 3'b000;
        wa  = 3'b001;
        n_state = S3;
      end
      S3 : begin
        ra0 = 3'b011;
        if(lt10)
          n_state = S6;
        else
          n_state = S4;
      end
      S4 : begin
        ra0 = 3'b011;
        ra1 = 3'b001;
        wa  = 3'b011;
        n_state = S5;
      end
      S5 : begin
        ra0 = 3'b010;
        ra1 = 3'b011;
        wa  = 3'b010;
        n_state = S3;
      end
      S6 : begin
        ra0 = 3'b000;
        ra1 = 3'b010;
        wa  = 3'b000;
      end
    endcase
  end
endmodule

module datapath(
  input logic       clk,
  input logic       rst_n,
  input logic       lt10,
  input logic       rf_srcsel,
  input logic [1:0] ra0,
  input logic [1:0] ra1,
  input logic [1:0] wa,
  input logic [1:0] we,
  output logic [5:0] rd0,
  output logic [5:0] rd1
);


  
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
  output  logic [31:0] rd1,
  output  logic [31:0] rd2
  );


    logic [31:0] ram_file [1:31];

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
  assign rd1 = (ra1 != 0) ? ram_file[ra1] : 32'd0;
  assign rd2 = (ra2 != 0) ? ram_file[ra2] : 32'd0;

endmodule

module alu(
  input   logic [31:0] rs1,
  input   logic [31:0] rs2,
  input   logic [ 3:0] alu_control,
  output  logic [31:0] alu_result,
  output  logic        b_taken
  );

endmodule
