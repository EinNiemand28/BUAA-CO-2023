`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:14:10 11/15/2023 
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
    input wire clk,
    input wire reset
);
    wire [31:0] InstrF;
    wire [31:0] NextPC, PCF;
    wire Stall = StallRsE || StallRtE || StallRsM || StallRtM;
    // always @(posedge clk) begin
    //     $display("%d", Stall);
    // end
    IFU u_ifu (
        .clk(clk),
        .reset(reset),
        .WE(!Stall),
        .NextPC(NextPC),
        .PC(PCF),
        .Instr(InstrF)
    );

    wire [31:0] InstrD;
    wire [31:0] PCD;
    IFID u_ifid (
        .clk(clk),
        .reset(reset),
        // .reset(reset || (!Stall && && ))
        .WE(!Stall),
        .InstrF(InstrF),
        .PCF(PCF),
        .InstrD(InstrD),
        .PCD(PCD)
    );

    wire Jump, Jr, SignExtend, ALUSrcD;
    wire [2:0] ALUOpD;
    wire MemWriteD, RegWriteD;
    wire [1:0] RegSrcD;
    wire [4:0] RegDstD;
    wire [4:0] BranchOp;
    wire [1:0] TuseRs, TuseRt, Tnew;
    Controller u_controller (
        .Instr(InstrD),
        .Jump(Jump),
        .Jr(Jr),
        .ALUOp(ALUOpD),
        .ALUSrc(ALUSrcD),
        .SignExtend(SignExtend),
        .MemWrite(MemWriteD),
        .RegWrite(RegWriteD),
        .RegDst(RegDstD),
        .RegSrc(RegSrcD),
        .BranchOp(BranchOp),
        .TuseRs(TuseRs),
        .TuseRt(TuseRt),
        .Tnew(Tnew)
    );

    wire [31:0] PCW;
    wire Judge = (InstrD[20:16] == 5'b0_0001);
    wire Branch;
    wire RegWriteW;
    wire [4:0] RegDstW;
    wire [31:0] RD1D, RD2D, OffsetD;
    GRF u_grf (
        .clk(clk),
        .reset(reset),
        .WE(RegWriteW),
        .A1(InstrD[25:21]),
        .A2(InstrD[20:16]),
        .A3(RegDstW),
        .WD(WriteRegW),
        .PC(PCW),
        .RD1(RD1D),
        .RD2(RD2D)
    );

    EXT u_ext (
        .imm16(InstrD[15:0]),
        .ExtOp(SignExtend),
        .imm32(OffsetD)
    );

    wire [31:0] ForwardRsD = (InstrD[25:21] == 0) ? 0 :
                ((RegDstE == InstrD[25:21]) && RegWriteE && ForwardE) ? WriteRegE :
                ((RegDstM == InstrD[25:21]) && RegWriteM && ForwardM) ? WriteRegM : RD1D;
    wire [31:0] ForwardRtD = (InstrD[20:16] == 0) ? 0 :
                ((RegDstE == InstrD[20:16]) && RegWriteE && ForwardE) ? WriteRegE :
                ((RegDstM == InstrD[20:16]) && RegWriteM && ForwardM) ? WriteRegM : RD2D;
    BranchControl u_branch_control (
        .rs(ForwardRsD),
        .rt(ForwardRtD),
        .BranchOp(BranchOp),
        .Judge(Judge),
        .Branch(Branch)
    );

    NPC u_npc (
        .PCF(PCF),
        .PCD(PCD),
        .Instr26(InstrD[25:0]),
        .Offset(OffsetD),
        .RegToJump(ForwardRsD),
        .Jump(Jump),
        .Jr(Jr),
        .Branch(Branch),
        .NextPC(NextPC)
    );

    wire [31:0] PCE, RD1E, RD2E;
    wire [2:0] ALUOpE;
    wire ALUSrcE, MemWriteE, RegWriteE;
    wire [1:0] RegSrcE, TnewE;
    wire [4:0] RegDstE, RsE, RtE, ShamtE;
    wire [31:0] OffsetE;
    wire RegWriteDNew = RegWriteD;
    IDEX u_idex (
        .clk(clk),
        .reset(reset || Stall),
        .CheckD(),
        .PCD(PCD),
        .ALUOpD(ALUOpD),
        .ALUSrcD(ALUSrcD),
        .MemWriteD(MemWriteD),
        .RegWriteD(RegWriteDNew),
        .TnewD(Tnew),
        .RegDstD(RegDstD),
        .RegSrcD(RegSrcD),
        .RsD(InstrD[25:21]),
        .RtD(InstrD[20:16]),
        .ShamtD(InstrD[10:6]),
        .OffsetD(OffsetD),
        .RD1D(ForwardRsD),
        .RD2D(ForwardRtD),
        .CheckE(),
        .PCE(PCE),
        .ALUOpE(ALUOpE),
        .ALUSrcE(ALUSrcE),
        .MemWriteE(MemWriteE),
        .RegWriteE(RegWriteE),
        .TnewE(TnewE),
        .RegSrcE(RegSrcE),
        .RegDstE(RegDstE),
        .RsE(RsE),
        .RtE(RtE),
        .ShamtE(ShamtE),
        .OffsetE(OffsetE),
        .RD1E(RD1E),
        .RD2E(RD2E)
    );

    wire StallRsE = (RegDstE != 0) && RegWriteE && (RegDstE == InstrD[25:21]) && (TuseRs < TnewE);
    wire StallRtE = (RegDstE != 0) && RegWriteE && (RegDstE == InstrD[20:16]) && (TuseRt < TnewE);
    wire [31:0] WriteRegE = (RegSrcE == 2'b10) ? PCE + 8 : 0;
    wire ForwardE = (TnewE == 2'b00);
    wire [31:0] ForwardRsE = (RsE == 0) ? 0 :
                ((RegDstM == RsE) && RegWriteM && ForwardM) ? WriteRegM : 
                ((RegDstW == RsE) && RegWriteW && ForwardW) ? WriteRegW : RD1E;
    wire [31:0] ForwardRtE = (RtE == 0) ? 0 :
                ((RegDstM == RtE) && RegWriteM && ForwardM) ? WriteRegM :
                ((RegDstW == RtE) && RegWriteW && ForwardW) ? WriteRegW : RD2E;
    wire [31:0] SrcBE = (ALUSrcE == 1'b1) ? OffsetE : ForwardRtE;
    wire [31:0] ResultE;
    ALU u_alu (
        .SrcA(ForwardRsE),
        .SrcB(SrcBE),
        .Shamt(ShamtE),
        .ALUOp(ALUOpE),
        .Result(ResultE)
    );

    wire [31:0] PCM;
    wire MemWriteM, RegWriteM;
    wire [1:0] RegSrcM, TnewM;
    wire [4:0] RegDstM, RtM;
    wire [31:0] ResultM, WriteDataM;
    EXME u_EXME (
        .clk(clk),
        .reset(reset),
        .CheckE(),
        .PCE(PCE),
        .RegWriteE(RegWriteE),
        .TnewE(TnewE),
        .RegSrcE(RegSrcE),
        .RegDstE(RegDstE),
        .ResultE(ResultE),
        .WriteDataE(ForwardRtE),
        .RtE(RtE),
        .MemWriteE(MemWriteE),
        .CheckM(),
        .PCM(PCM),
        .RegWriteM(RegWriteM),
        .TnewM(TnewM),
        .RegSrcM(RegSrcM),
        .RegDstM(RegDstM),
        .ResultM(ResultM),
        .WriteDataM(WriteDataM),
        .RtM(RtM),
        .MemWriteM(MemWriteM)
    );

    wire StallRsM = (RegDstM != 0) && (RegDstM == InstrD[25:21]) && RegWriteM && (TuseRs < TnewM);
    wire StallRtM = (RegDstM != 0) && (RegDstM == InstrD[20:16]) && RegWriteM && (TuseRt < TnewM);
    wire [31:0] WriteRegM = (RegSrcM == 2'b10) ? PCM + 8 :
                            (RegSrcM == 2'b00) ? ResultM : 0;
    wire ForwardM = (TnewM == 2'b00);
    wire [31:0] ForwardWriteDataM = (RtM == 0) ? 0 :
                ((RtM == RegDstW) && RegWriteW && ForwardW) ? WriteRegW : WriteDataM;
    wire [31:0] ReadDataM;
    DM u_dm (
        .clk(clk),
        .reset(reset),
        .WE(MemWriteM),
        .Check(),
        .Addr(ResultM),
        .WD(ForwardWriteDataM),
        .PC(PCM),
        .RD(ReadDataM)
    );

    wire [31:0] ResultW, ReadDataW;
    wire [1:0] RegSrcW;
    MEWB u_mewb (
        .clk(clk),
        .reset(reset),
        .PCM(PCM),
        .RegWriteM(RegWriteM),
        .RegSrcM(RegSrcM),
        .RegDstM(RegDstM),
        .ReadDataM(ReadDataM),
        .ResultM(ResultM),
        .PCW(PCW),
        .RegWriteW(RegWriteW),
        .RegSrcW(RegSrcW),
        .RegDstW(RegDstW),
        .ReadDataW(ReadDataW),
        .ResultW(ResultW)
    );

    wire ForwardW = 1'b1;
    wire [31:0] WriteRegW = (RegSrcW == 2'b10) ? PCW + 8 :
                            (RegSrcW == 2'b01) ? ReadDataW : ResultW;
endmodule
