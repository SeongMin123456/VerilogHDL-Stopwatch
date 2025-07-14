`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/21 09:59:20
// Design Name: 
// Module Name: Digit_set
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


module Digit_set(
    input CLK,
    input [3:0] N_HIGH,
    input [3:0] N_LOW,
    input CA,
    output reg [6:0] AN
    );

wire [3:0] digit;

assign digit = CA ? N_HIGH : N_LOW;

//always @(posedge CLK) begin
//    if(CA)  digit <= N_HIGH;
//    else    digit <= N_LOW;
//end

always @(digit) begin
    case(digit)
        4'h0: AN = 7'h3F;
        4'h1: AN = 7'h06;
        4'h2: AN = 7'h5B;
        4'h3: AN = 7'h4F;
        4'h4: AN = 7'h66;
        4'h5: AN = 7'h6D;
        4'h6: AN = 7'h7D;
        4'h7: AN = 7'h27;
        4'h8: AN = 7'h7F;
        4'h9: AN = 7'h67;
        default : AN = 7'h00;
     endcase
end

endmodule
