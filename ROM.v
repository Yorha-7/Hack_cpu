`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2025 17:25:19
// Design Name: 
// Module Name: ROM
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

module ROM(
    input wire clk, 
    input wire [15:0] addr,        // 256 locations -> 8-bit address
    output reg [15:0] instr
);
    reg [15:0] rom [0:255];

   initial $readmemb("program.mem", rom);
    always @(*) begin
        instr = rom[addr];
        
    end
endmodule
