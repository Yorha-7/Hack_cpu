`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2025 11:08:01
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb;
reg [15:0] x,y;
reg [5:0] signal;
wire [15:0] out;
wire cout;
ALU dut(.x(x), 
        .y(y),  
        .signal(signal), 
        .out(out), 
        .cout(cout)
        );
        initial begin 
          x = 16'h0045; y = 16'h0045; signal = 6'b000010; #10;
          x = 16'h0045; y = 16'h0040; signal = 6'b000010; #10;
          x = 16'h0045; y = 16'h0045; signal = 6'b000010; #10 
          x = 16'h0045; y = 16'h0040; signal = 6'b000010; #10 $finish;  
        end
endmodule
