`timescale 1ns / 1ps
module adder(
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [8:0] y
    );

    always_comb begin       //always_comb : combinational logic , *() 
        y = a + b; 
    end
endmodule
