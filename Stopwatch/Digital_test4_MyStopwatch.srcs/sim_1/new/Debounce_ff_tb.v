`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/06 11:14:49
// Design Name: 
// Module Name: Debounce_ff_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Debounce_ff_tb();


reg clk, btn;
wire BTN_R, BTN_F;

Debounce_FF uut(
    .CLK(clk),
    .BTN(btn),
    .BTN_R(BTN_R),
    .BTN_F(BTN_F)
    );

always #3   clk = ~clk;

initial begin
    clk <= 0;
    btn <= 0;
    #1;
    btn <= 1;
    #1;
    btn <= 0;
    #1;
    btn <= 1;
    #1;
    btn <= 0;
    #1;
    btn <= 1;
    #1;
    btn <= 0;
    #1;
    btn <= 1;
    #1;
    btn <= 0;
    #1;
    btn <= 1;
    #1;
    btn <= 0;
    #1;
    btn <= 1;
    #1;
    btn <= 0;
    #1;
    btn <= 1;
    #1;
    btn <= 0;
    #1;
    btn <= 1;
    #1;
    btn <= 0;
    #1;
    btn <= 1;
    #50;
    btn <= 0;
    #1;
    btn <= 1;
    #1;
    btn <= 0;
    #1;
    btn <= 1;
    #1;
    btn <= 0;
    #1;
    btn <= 1;
    #1;
    btn <= 0;
    #1;
    btn <= 1;
    #1;
    btn <= 0;
end

endmodule
