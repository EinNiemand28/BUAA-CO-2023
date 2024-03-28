`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:37:21 11/11/2023 
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
    input wire [4:0] Shamt,
    input wire [3:0] ALUOp,
    input wire ALUOv,
    input wire DMOv,
    output wire [31:0] Result,
    output wire ExcOv,
    output wire ExcDMOv
);
    wire [32:0] ExtA = {SrcA[31], SrcA};
    wire [32:0] ExtB = {SrcB[31], SrcB};
    wire [32:0] ExtAdd = ExtA + ExtB;
    wire [32:0] ExtSub = ExtA - ExtB;
    assign ExcOv = (ALUOv) &&
                   (((ALUOp == 4'd0) && ExtAdd[32] != ExtAdd[31]) || 
                    ((ALUOp == 4'd1) && ExtSub[32] != ExtSub[31]));
    assign ExcDMOv = (DMOv) &&
                     (((ALUOp == 4'd0) && ExtAdd[32] != ExtAdd[31]) || 
                      ((ALUOp == 4'd1) && ExtSub[32] != ExtSub[31]));

    wire slt = $signed(SrcA) < $signed(SrcB);
    wire sltu = SrcA < SrcB;
    assign Result = (ALUOp == 4'd0) ? SrcA + SrcB :
                    (ALUOp == 4'd1) ? SrcA - SrcB :
                    (ALUOp == 4'd2) ? SrcA & SrcB :
                    (ALUOp == 4'd3) ? SrcA | SrcB :
                    (ALUOp == 4'd4) ? (SrcB << Shamt) :
                    (ALUOp == 4'd5) ? {SrcB[15:0], {16'b0}} :
                    (ALUOp == 4'd6) ? (slt ? 32'b1 : 32'b0) :
                    (ALUOp == 4'd7) ? (sltu ? 32'b1 : 32'b0) : `InitData;

endmodule
