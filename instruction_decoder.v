`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2025 16:07:12
// Design Name: 
// Module Name: instruction_decoder
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


module instruction_decoder(
    input wire [15:0] instr,
    input wire Zy,Cy,clk,
    input wire rst,
    output reg we_d,we_a,we_m,PC_e,a,dis
    );
    initial begin 
        PC_e = 0;we_d =0;we_a=0;we_m=0;a=0;
    end
  
    always @(*) begin
    if (instr[15] == 1) begin  // C-type instruction
        we_a = instr[5];
        we_m = instr[3];
        we_d = instr[4];
        a = instr[12];
        //if (we_m && ~we_a && we_d) dis <= 1;
        //else dis <= 0;
        
        // PC update logic
        case (instr[2:0])
            3'b000: PC_e = 0;
            3'b001: PC_e = (Cy == 0 && Zy == 0) ? 1 : 0;
            3'b010: PC_e = (Cy == 0 && Zy == 1) ? 1 : 0;
            3'b011: PC_e = (Cy == 0) ? 1 : 0;
            3'b100: PC_e = (Cy == 1 && Zy == 0) ? 1 : 0;
            3'b101: PC_e = (Zy == 0) ? 1 : 0;
            3'b110: PC_e = (Cy == 1) ? 1 : 0;
            3'b111: PC_e = 1;
            default: PC_e = 0;
        endcase
    end
    else begin  // A-type instruction (instr[15] == 0)
        we_a = 1;
        we_d = 0;
        we_m = 0;
        a = 0;
        PC_e = 0;
    end
end

endmodule
