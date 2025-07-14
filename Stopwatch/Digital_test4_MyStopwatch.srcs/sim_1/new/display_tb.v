`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/21 15:31:03
// Design Name: 
// Module Name: display_tb
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

module display_tb();

reg [3:0] Usec_h, Usec_l, sec_l, min_l;
reg [2:0] sec_h, min_h;
reg MODE, CLK;

wire [6:0] DIGIT1, DIGIT2;
wire CA;

Stopwatch_Display tt1(
    .Usec_h(Usec_h),
    .Usec_l(Usec_l),
    .sec_h(sec_h),
    .sec_l(sec_l),
    .min_h(min_h),
    .min_l(min_l),
    .MODE(MODE), // 0 : Usec & sec, 1 : sec & min
    .CLK(CLK),
    .DIGIT1(DIGIT1),    // Min or Sec
    .DIGIT2(DIGIT2),    // Sec or Usec
    .CA(CA)
    );

// tick Logic
Tick_make tt2(
    .CLK(CLK),
    .TICK(CA)
    );

always #2 CLK = ~CLK;

initial begin
    CLK <= 1'b0;
    MODE <= 0;
    Usec_h <= 4'b0;
    Usec_l <= 4'b0;
    sec_h <= 3'b0;
    sec_l <= 4'b0;
    min_h <= 3'b0;
    min_l <= 4'b0;
    #10;
    Usec_h <= 4'd1;
    #8;
    Usec_l <= 4'd1;
    #8;
    sec_h <= 3'd1;
    #8;
    sec_l <= 4'd1;
    #8;
    MODE <= 1'b1;
    #8;
    min_h <= 3'd1;
    #8;
    min_l <= 4'd1;
end

endmodule
