`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2025 17:11:24
// Design Name: 
// Module Name: program_counter
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


module program_counter(
    input wire reset,
    input wire [15:0] PC_in,
    input wire clk,
    input wire PC_we,
    output reg [15:0] PC_out        
);
initial PC_out = 0;
    always @(posedge clk or posedge reset) begin
        if (reset) 
            PC_out <= 0;
        else if (PC_we) 
            PC_out <= PC_in;
        else 
            PC_out <= PC_out + 1;
    end
endmodule
