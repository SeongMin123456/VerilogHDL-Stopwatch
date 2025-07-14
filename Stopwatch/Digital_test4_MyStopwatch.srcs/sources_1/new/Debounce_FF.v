`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/06 11:08:31
// Design Name: 
// Module Name: Debounce_FF
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


module Debounce_FF(
    input CLK,
    input BTN,
    output BTN_R,
    output BTN_F
    );

reg BTN_ff1 = 0, BTN_ff2 = 0, BTN_ff3 = 0;

always @(posedge CLK) begin
    BTN_ff1 <= BTN;
    BTN_ff2 <= BTN_ff1;
    BTN_ff3 <= BTN_ff2;
end

assign BTN_R = BTN_ff2 & ~BTN_ff3;
assign BTN_F = ~BTN_ff2 & BTN_ff3;

endmodule