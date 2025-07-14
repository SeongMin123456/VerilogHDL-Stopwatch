`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/21 09:44:05
// Design Name: 
// Module Name: Tick_make
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

module PLS_1k(
    input CLK,
    output PLS_1k
    );

parameter CLK_FREQ = 125_000_000;   // 125MHz
parameter TICK_Trig = CLK_FREQ/1000;    // 1mS(1kHz) Trigger

reg [16:0] Tick_cnt = 0;
reg tick = 1;
assign PLS_1k = tick;

always @(posedge CLK) begin
    if(Tick_cnt == (TICK_Trig-1)/2) begin
        Tick_cnt <= 0;
        tick <= ~tick;
    end else begin
        Tick_cnt <= Tick_cnt + 1;
    end
end

endmodule
