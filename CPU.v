`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2025 12:00:14
// Design Name: 
// Module Name: CPU
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


module CPU(
    input clk,
    input reset,
    //output [15:0] data_out
    output [6:0] seg
    //output [3:0] an
   );                     // basic wires
    (* keep = "true", dont_touch = "true" *)wire [15:0] x_in,y_in;
    (* keep = "true", dont_touch = "true" *)wire [15:0] ALU_out;
    //wire [15:0] A_in;
    //(* keep = "true", dont_touch = "true" *)wire we_a;
    (* keep = "true", dont_touch = "true" *)wire [15:0] M_out;
    (* keep = "true", dont_touch = "true" *)wire cout;
    (* keep = "true", dont_touch = "true" *)wire zero_line;
    (* keep = "true", dont_touch = "true" *)wire [15:0] pc_out;
    (* keep = "true", dont_touch = "true" *)wire [15:0] instr;
                         // buses
    (* keep = "true", dont_touch = "true" *)wire [15:0] data_bus,addr_bus;
    (* keep = "true", dont_touch = "true" *)wire [5:0] ctrl_bus;
    (* keep = "true", dont_touch = "true" *)wire [15:0] ir_out;
    (* keep = "true", dont_touch = "true" *)wire [6:0] seg_wire;
    //(* keep = "true", dont_touch = "true" *)wire [3:0] an_wire = an;
    //(* keep = "true", dont_touch = "true" *)wire [15:0] ssd_in;
                         // assigning pre values to wires
    // assign we_a = ~instr[15];
    //assign A_in = instr[15:0];
    //the Arithmatic and logic unit
    (* keep = "true", dont_touch = "true" *)ALU alu(.x(y_in), .y(x_in), .signal(ir_out[11:6]), .out(ALU_out), .cout(cout));
    //register A
    (* keep = "true", dont_touch = "true" *)wire [15:0] A_in;
    (* keep = "true", dont_touch = "true" *)assign A_in = (ir_out[15] == 0) ? ir_out : ALU_out;
    (* keep = "true", dont_touch = "true" *)register A(.reset(reset), .data_in(A_in), .we_X(ctrl_bus[0]), .X_out(addr_bus), .clk(clk));
    //register D
    (* keep = "true", dont_touch = "true" *)register D(.reset(reset), .data_in(ALU_out), .we_X(ctrl_bus[2]), .X_out(y_in), .clk(clk));
    // mux gate for a bit in c type of instruction
    (* keep = "true", dont_touch = "true" *)mux mux_1(.A_out(addr_bus), .M_out(M_out), .sel(ctrl_bus[4]), .x_in(x_in));
    // RAM
    (* keep = "true", dont_touch = "true" *)RAM ram(.data_in(ALU_out), .addr(addr_bus), .we_M(ctrl_bus[1]), .clk(clk), .reset(reset), .data_out(M_out));
    //Zero Checker
    (* keep = "true", dont_touch = "true" *)zero_checker zc(.data_in(ALU_out), .Zy(zero_line));  // zerochecker Zy will be connected via wire to the instruction decoder input
    // instruction decoder
    (* keep = "true", dont_touch = "true" *)instruction_decoder id(.rst(reset), .instr(ir_out), .clk(clk), .Zy(zero_line), .Cy(cout), .we_a(ctrl_bus[0]), .we_m(ctrl_bus[1]), .we_d(ctrl_bus[2]), .PC_e(ctrl_bus[3]), .a(ctrl_bus[4]), .dis(ctrl_bus[5]));
    // Program Counter
    //instruction register
    (* keep = "true", dont_touch = "true" *)instruction_register IR(.instr(instr), .reset(reset), .clk(clk), .instr_out(ir_out));
    (* keep = "true", dont_touch = "true" *)program_counter pc(.reset(reset),.PC_in(addr_bus), .PC_out(pc_out), .PC_we(ctrl_bus[3]), .clk(clk)); // assign PC_out connect it with wire to the ROM addresse line
    // ROM or program memory 
    (* keep = "true", dont_touch = "true" *)ROM rom(.clk(clk), .addr(pc_out), .instr(instr));
    //ssd reg
    //(* keep = "true", dont_touch = "true" *)register ssd_reg(.reset(reset), .data_in(y_in), .we_X(ctrl_bus[5]), .X_out(ssd_in), .clk(clk));
    //SSD_Display
    (* keep = "true", dont_touch = "true" *)display dis(.data_in(y_in), .seg_out(seg_wire));
    //(* keep = "true", dont_touch = "true" *)ssd ddd(.clk(clk), .data_in(y_in), .seg(seg_wire), .an(an_wire));
    (* keep = "true", dont_touch = "true" *)assign data_bus = ALU_out;
    (* keep = "true", dont_touch = "true" *)assign seg = seg_wire;
    //(* keep = "true", dont_touch = "true" *)assign data_out = y_in;
endmodule
