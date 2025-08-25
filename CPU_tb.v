`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2025 13:43:50
// Design Name: 
// Module Name: CPU_tb
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


module CPU_tb;

    // Inputs
    reg clk;
    reg reset;

    // Outputs
    wire [6:0] seg;

    // Instantiate the CPU
    CPU uut (
        .clk(clk),
        .reset(reset),
        .seg(seg)
    );

    // Clock generation: 10ns period
    initial clk = 1;
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize
        reset = 1;
        #5;           // Hold reset for a few cycles
        reset = 0;

        // Let the CPU run for some cycles
        #2000;

        // Stop simulation
       $finish;
    end
always @(posedge clk) begin
    // print instruction and control
    $display("T=%0t pc=%h instr=%h ctrl=%b we_a=%b we_d=%b we_m=%b PC_e=%b a=%b",
             $time, uut.pc_out, uut.instr, uut.ctrl_bus, uut.ctrl_bus[0], uut.ctrl_bus[2], uut.ctrl_bus[1], uut.ctrl_bus[3], uut.ctrl_bus[4]);

    // print ALU control bits and ALU inputs/outputs
    $display("      | ALU_ctrl=%b  x_in=%h  y_in=%h  ALU_out=%h  cout=%b",
             uut.instr[11:6], uut.x_in, uut.y_in, uut.ALU_out, uut.cout);

    // helpful separator for the cycle where we expect D=A
    if (uut.ctrl_bus[2]) $display("      ==> D write is enabled this cycle (we_d=1)");
end


endmodule
