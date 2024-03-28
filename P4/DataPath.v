`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:06:44 11/03/2023 
// Design Name: 
// Module Name:    DataPath 
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
module DataPath (
    input wire reset,
    input wire clk
);
    wire [31:0] Instr;
    wire [31:0] PC;
    wire [31:0] NextPC;
    wire [31:0] PC4;
    wire [31:0] RD1;
    wire [31:0] RD2;
    wire [31:0] Imm32;

    wire [1:0] RegDst;
    wire Jump;
    wire Jr;
    wire [2:0] BranchOp;
    wire [1:0] RegSrc;
    wire RegWrite;
    wire MemWrite;
    wire SignExtend;
    wire ALUSrc;
    wire [2:0] ALUOp;
    wire [2:0] MemOp;

    wire [31:0] result;
    wire equal;
    wire Judge = (Instr[20:16] == 5'b00001);
    wire Branch;
    wire [31:0] RD;

    wire [4:0] RegAddr = (RegDst == 2'b10) ? 5'h1f :
                         (RegDst == 2'b01) ? Instr[20:16] : Instr[15:11];
    wire [31:0] RegData = (RegSrc == 2'b10) ? PC4 :
                          (RegSrc == 2'b01) ? RD : result;
    wire [31:0] SrcB = (ALUSrc == 1'b1) ? Imm32 : RD2;

    IFU u_ifu (
        .reset(reset),
        .clk(clk),
        .NextPC(NextPC),
        .PC(PC),
        .Instr(Instr)
    );

    NPC u_npc(
        .PC(PC),
        .Instr26(Instr[25:0]),
        .Offset(Imm32),
        .RegToJump(RD1),
        .Jump(Jump),
        .Branch(Branch),
        .Jr(Jr),
        .NextPC(NextPC),
        .PC4(PC4)
    );

    GRF u_grf(
        .clk(clk),
        .reset(reset),
        .WE(RegWrite),
        .A1(Instr[25:21]),
        .A2(Instr[20:16]),
        .A3(RegAddr),
        .WD(RegData),
        .PC(PC),
        .RD1(RD1),
        .RD2(RD2)
    );

    ALU u_alu(
        .SrcA(RD1),
        .SrcB(SrcB),
        .shamt(Instr[10:6]),
        .ALUOp(ALUOp),
        .equal(equal),
        .result(result)
    );

    DM u_dm(
        .clk(clk),
        .reset(reset),
        .WE(MemWrite),
        .Addr(result),
        .WD(RD2),
        .MemOp(MemOp),
        .PC(PC),
        .RD(RD)
    );

    EXT u_ext(
        .imm16(Instr[15:0]),
        .ExtOp(SignExtend),
        .imm32(Imm32)
    );

    Controller u_controller(
        .op(Instr[31:26]),
        .funct(Instr[5:0]),
        .RegDst(RegDst),
        .Jump(Jump),
        .Jr(Jr),
        .BranchOp(BranchOp),
        .RegSrc(RegSrc),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .SignExtend(SignExtend),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUOp),
        .MemOp(MemOp)
    );

    BranchControl u_branchcontrol(
        .BranchOp(BranchOp),
        .equal(equal),
        .rs(RD1),
        .Judge(Judge),
        .Branch(Branch)
    );
endmodule
