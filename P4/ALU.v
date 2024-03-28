`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:15:42 11/03/2023 
// Design Name: 
// Module Name:    ALU 
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
`define InitData 32'h0000_0000
module ALU (
    input wire [31:0] SrcA,
    input wire [31:0] SrcB,
    input wire [4:0] shamt,
    input wire [2:0] ALUOp,
    output wire equal,
    output wire [31:0] result
);
    assign equal = (SrcA == SrcB) ? 1'b1 : 1'b0;
    assign result = (ALUOp == 3'd0) ? SrcA + SrcB :
                    (ALUOp == 3'd1) ? SrcA - SrcB :
                    (ALUOp == 3'd2) ? SrcA & SrcB :
                    (ALUOp == 3'd3) ? SrcA | SrcB :
                    (ALUOp == 3'd4) ? SrcB << shamt :
                    (ALUOp == 3'd5) ? {SrcB[15:0], {16'b0}} : `InitData;

endmodule
