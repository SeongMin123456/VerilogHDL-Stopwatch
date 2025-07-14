`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/21 09:31:59
// Design Name: 
// Module Name: Stopwatch_Display
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

module Stopwatch_Display(
    input [3:0] Usec_h,
    input [3:0] Usec_l,
    input [2:0] sec_h,
    input [3:0] sec_l,
    input [2:0] min_h,
    input [3:0] min_l,
    input MODE, // 0 : Usec & sec, 1 : sec & min
    input CLK,
    input PLS_1k,
    output reg [6:0] DIGIT1,    // Min or Sec
    output reg [6:0] DIGIT2,    // Sec or Usec
    output CA
    );

assign CA = PLS_1k;

// DIGIT Logic Usec
wire [6:0] digit_Usec;
Digit_set uut4(
    .CLK(CLK),
    .N_HIGH(Usec_h),
    .N_LOW(Usec_l),
    .CA(CA),
    .AN(digit_Usec)
    );

// DIGIT Logic sec
wire [6:0] digit_sec;
wire [3:0] SEC_h;
assign SEC_h = {1'b0, sec_h};
Digit_set uut5(
    .CLK(CLK),
    .N_HIGH(SEC_h),
    .N_LOW(sec_l),
    .CA(CA),
    .AN(digit_sec)
    );

// DIGIT Logic min
wire [6:0] digit_min;
wire [3:0] MIN_h;
assign MIN_h = {1'b0, min_h};
Digit_set uut6(
    .CLK(CLK),
    .N_HIGH(MIN_h),
    .N_LOW(min_l),
    .CA(CA),
    .AN(digit_min)
    );

// Display Logic
always @(posedge CLK) begin
    if(MODE) begin
        DIGIT1 <= digit_min;
        DIGIT2 <= digit_sec;
    end else begin
        DIGIT1 <= digit_sec;
        DIGIT2 <= digit_Usec;
    end
end

endmodule
