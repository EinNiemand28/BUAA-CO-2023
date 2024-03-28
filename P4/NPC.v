`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:56:12 11/03/2023 
// Design Name: 
// Module Name:    NPC 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`default_nettype none
module NPC (
    input wire [31:0] PC,
    input wire [25:0] Instr26,
    input wire [31:0] Offset,
    input wire [31:0] RegToJump,
    input wire Jump,
    input wire Branch,
    input wire Jr,
    output wire [31:0] NextPC,
    output wire [31:0] PC4
);
    assign PC4 = PC + 4;
    assign NextPC = (Jump == 1'b1) ? ({PC[31:28], Instr26, 2'b00}) :
                    (Branch == 1'b1) ? (PC + 4 + {Offset[29:0], 2'b00}) :
                    (Jr == 1'b1) ? RegToJump : (PC + 4);

endmodule
