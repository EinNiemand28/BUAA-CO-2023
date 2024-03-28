`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:48:36 11/11/2023 
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
    input wire [31:0] PCF,
    input wire [31:0] PCD,
    input wire [25:0] Instr26,
    input wire [31:0] Offset,
    input wire [31:0] RegToJump,
    input wire Jump,
    input wire Branch,
    input wire Jr,
    output wire [31:0] NextPC
);
    assign NextPC = (Jump == 1'b1) ? {{PCD[31:28], Instr26, 2'b0}} :
                    (Branch == 1'b1) ? (PCD + 4 + {Offset[29:0], 2'b0}) :
                    (Jr == 1'b1) ? RegToJump : PCF + 4;

endmodule
