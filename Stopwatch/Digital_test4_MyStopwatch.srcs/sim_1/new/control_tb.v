`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/21 13:22:57
// Design Name: 
// Module Name: control_tb
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


module control_tb();

reg clk, btn0, btn1;
wire [1:0] FSM_State;
wire MODE;

Stopwatch_Control #(.CLK_FREQ(2)) uut3(
    .CLK(clk),
    .BTN0(btn0),
    .BTN1(btn1),
    .FSM_State(FSM_State),
    .MODE(MODE)
    );

always #2 clk = ~clk;

initial begin
    clk <= 1'b0;
    btn0 <= 1'b0;
    btn1 <= 1'b0;
    
    #8;
    btn0 <= 1'b1;   // start
    #400;
    btn0 <= 1'b0;
    #8;
    btn1 <= 1'b1;
    #400;
    btn1 <= 1'b0;   // mode 1
    #40;
    btn1 <= 1'b1;
    #400;
    btn1 <= 1'b0;   // mode 0
    #40;
    btn0 <= 1'b1;   // Pause
    #400;
    btn0 <= 1'b0;
    #40;
    btn1 <= 1'b1;   // Clear
end

endmodule
