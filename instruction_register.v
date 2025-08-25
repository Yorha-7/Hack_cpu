`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2025 19:00:46
// Design Name: 
// Module Name: instruction_register
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


module instruction_register(
    input [15:0] instr,
    input clk,
    input reset,
    output [15:0]instr_out
    );
    reg [15:0] ir;
    always @(posedge clk or posedge reset) begin
        if (reset) ir<= 16'h0000;
        else ir <= instr;
    end
    assign instr_out = ir;
endmodule
