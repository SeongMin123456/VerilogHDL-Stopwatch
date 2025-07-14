`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/20 12:50:34
// Design Name: 
// Module Name: PLS_100Hz
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

module PLS_100Hz(
    input CLK,
    input TICK,   // 1kHz
    output reg PLS_100 = 0
    );

reg [3:0] Pulse_cnt = 0;

// Duty 50, 10mS Pulse Logic
always @(posedge TICK) begin
    if(Pulse_cnt == 4) begin
        Pulse_cnt <= 0;
        PLS_100 <= ~PLS_100;
    end else begin
        Pulse_cnt <= Pulse_cnt + 1;
    end
end

endmodule
