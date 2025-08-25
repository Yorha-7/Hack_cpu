`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2025 16:34:05
// Design Name: 
// Module Name: instruction_decoder_tb
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


module instruction_decoder_tb;
    reg [15:0] instr;
    reg Zy,Cy,clk;
    wire we_d,we_m,we_a,PC_e,a; 
    instruction_decoder dut( .instr(instr), .Zy(Zy), .Cy(Cy), .clk(clk), .we_d(we_d), .we_a(we_a), .we_m(we_m), .PC_e(PC_e), .a(a));
    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
        instr = 16'h0056; Zy = 0; Cy = 0; #10;
        instr = 16'h8045; Zy = 1; Cy = 0; #10;
        instr = 16'h0056; Zy = 0; Cy = 0; #10;
        instr = 16'h813B; Zy = 1; Cy = 0; #10;
        instr = 16'h0056; Zy = 0; Cy = 0; #10; 
        instr = 16'h813B; Zy = 1; Cy = 0; #10$finish; 
    end
endmodule
