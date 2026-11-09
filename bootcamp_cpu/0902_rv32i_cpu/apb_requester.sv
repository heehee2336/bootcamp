module apb_requester(
  // CPU
  input   logic         clk,
  input   logic         rst_n,
  input   logic [31:0]  bus_addr,
  input   logic [31:0]  bus_wdata,
  input   logic         transfer,
  input   logic         bus_we,
  output  logic         pready,
  output  logic [31:0]  bus_rdata
  // apb completer
  input   logic         pready0,
  input   logic         pready1,
  input   logic         pready2,
  input   logic         pready3,
  input   logic         pready4,
  input   logic         pready5,
  input   logic         pready6,
  input   logic [31:0]  prdata0,
  input   logic [31:0]  prdata1,
  input   logic [31:0]  prdata2,
  input   logic [31:0]  prdata3,
  input   logic [31:0]  prdata4,
  input   logic [31:0]  prdata5,
  input   logic [31:0]  prdata6,
  output  logic [31:0]  paddr,
  output  logic [31:0]  pwdata,
  output  logic         pwrite,
  output  logic         penable,
  output  logic         psel0,
  output  logic         psel1,
  output  logic         psel2,
  output  logic         psel3,
  output  logic         psel4,
  output  logic         psel5,
  output  logic         psel6
);


  typedef enum logic [1:0] {
   IDLE,
   SETUP,
   ACCESS
  } state_e;

  state_e c_state, n_state;

  logic addr_dec_en;
  logic [2:0] mux_sel;
  logic [31:0] temp_PADDR, temp_PADDR_next;
  logic [31:0] temp_PWDATA, temp_PWDATA_next;
  logic temp_PWRITE, temp_PWRITE_next;

  assign paddr = bus_addr;
  assign pwdata = bus_wdata;
  assign rwrite = bus_we;

 always_ff @(posedge clk) begin
    if(!rst_n) begin
      c_state <= IDLE;
      temp_PADDR <= 32'h0;
      temp_PWDATA <= 32'h0;
      temp_PWRITE <= 1'b0;
    end else begin
      c_state <= n_state;
      temp_PADDR <= temp_PADDR_next;
      temp_PWDATA <= temp_PWDATA_next;
      temp_PWRITE <= temp_PWRITE_next;
    end
  end

  always_comb begin
    n_state     = c_state;
    addr_dec_en = 1'b0;
    penable     = 1'b0;
    temp_PADDR_next  = temp_PADDR;
    temp_PWDATA_next = temp_PWDATA;
    temp_PWRITE_next = temp_PWRITE;
    case(c_state)
     IDLE : begin
      if(transfer) begin
        temp_PADDR_next  = {4'b0000,bus_paddr[27:0]};
        temp_PWDATA_next = bus_pwdata;
        temp_PWRITE_next = bus_pwrite;
        n_state = SETUP;
      end
     end
     SETUP : begin
        addr_dec_en = 1'b1;
        penable     = 1'b0;
        n_state     = ACCESS;
     end
     ACCESS : begin
        addr_dec_en = 1'b1;
        penable     = 1'b1;
        if(ready)
          n_state = IDLE;
     end
   endcase
  end

  address_decoder U_APB_DECODER (
    .enable (addr_dec_en),
    .mux_sel(mux_sel),
    .*
  );

  mux_5x1 U_APB_MUX (
    sel (mux_sel),
    .*
  );

endmodule

module address_decoder(
  input   logic         enable
  input   logic [31:0]  paddr,
  input   logic [2:0]   mux_sel,
  output  logic         psel0,
  output  logic         psel1,
  output  logic         psel2,
  output  logic         psel3,
  output  logic         psel4,
  output  logic         psel5,
  output  logic         psel6,

);

  always_comb begin
     psel0    = 1'b0;
     psel1    = 1'b0;
     psel2    = 1'b0;
     psel3    = 1'b0;
     psel4    = 1'b0;
     psel5    = 1'b0;
     psel6    = 1'b0;
     mux_sel  = 3'b000;
    case(paddr[31:28])
      4'b0001 : begin     //apb ram
        psel0   = 1'b1;
        mux_sel = 3'b000;
      end
      4'b0010 : begin     // periphral, gpi, gpo, gpio, fnd, uart ...
        case(paddr[11:8])
          4'b0000 : begin
            psel1   = 1'b1;
            mux_sel = 3'b001;
          end
          4'b0001 : begin
            psel2   = 1'b1;
            mux_sel = 3'b010;
          end
          4'b0010 : begin
            psel3   = 1'b1;
            mux_sel = 3'b011;
          end
          4'b0011 : begin
            psel4   = 1'b1;
            mux_sel = 3'b100;
          end
          4'b0100 : begin
            psel5   = 1'b1;
            mux_sel = 3'b101;
          end
          4'b0101 : begin
            psel6   = 1'b1;
            mux_sel = 3'b110;
          end
        endcase
      end
     endcase
  end

endmodule

module mux_5x1 (
  input   logic [ 2:0]  sel,
  output  logic [31:0]  bus_prdata,
  output  logic         ready,

  input   logic [31:0]  prdata0,
  input   logic [31:0]  prdata1,
  input   logic [31:0]  prdata2,
  input   logic [31:0]  prdata3,
  input   logic [31:0]  prdata4,
  input   logic [31:0]  prdata5,
  input   logic [31:0]  prdata6,
  output  logic         pready0,
  output  logic         pready1,
  output  logic         pready2,
  output  logic         pready3,
  output  logic         pready4,
  output  logic         pready5,
  output  logic         pready6,
  );

  always_comb begin
    case (sel)
      3'b000 : begin
        bus_rdata = prdata0;
        pready0 = 1'b1;
        ready = 1'b1;
      end
      3'b001 : begin
        bus_rdata = prdata1;
        pready1 = 1'b1;
        ready = 1'b1;
      end
      3'b010 : begin
        bus_rdata = prdata2;
        pready2 = 1'b1;
        ready = 1'b1;
      end
      3'b011 : begin
        bus_rdata = prdata3;
        pready3 = 1'b1;
        ready = 1'b1;
      end
      3'b100 : begin
        bus_rdata = prdata4;
        pready4 = 1'b1;
        ready = 1'b1;
      end
      3'b101 : begin
        bus_rdata = prdata5;
        pready5 = 1'b1;
        ready = 1'b1;
      end
      3'b110 : begin
        bus_rdata = prdata6;
        pready6 = 1'b1;
        ready = 1'b1;
      end

    endcase

endmodule
