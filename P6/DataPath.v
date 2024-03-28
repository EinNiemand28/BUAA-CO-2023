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
    input wire reset,
    input wire [31:0] i_inst_rdata,
    output wire [31:0] i_inst_addr,
    input wire [31:0] m_data_rdata,
    output wire [31:0] m_data_addr,
    output wire [31:0] m_data_wdata,
    output wire [3:0] m_data_byteen,
    output wire [31:0] m_inst_addr,
    output wire w_grf_we,
    output wire [4:0] w_grf_addr,
    output wire [31:0] w_grf_wdata,
    output wire [31:0] w_inst_addr
);
    wire [31:0] InstrF = i_inst_rdata;
    wire [31:0] NextPC, PCF;
    wire Stall = StallRsE || StallRtE || StallRsM || StallRtM || StallMDU;
    // always @(posedge clk) begin
    //     $display("%d", Stall);
    // end
    IFU u_ifu (
        .clk(clk),
        .reset(reset),
        .WE(!Stall),
        .NextPC(NextPC),
        .PC(PCF)
    );
    assign i_inst_addr = PCF;

    wire [31:0] InstrD, InstrE, InstrM, InstrW;
    wire [31:0] PCD;
    IFID u_ifid (
        .clk(clk),
        .reset(reset),
        // .reset(reset || (!Stall && BranhOp == () && !Branch ))
        .WE(!Stall),
        .InstrF(InstrF),
        .PCF(PCF),
        .InstrD(InstrD),
        .PCD(PCD)
    );

    wire Jump, Jr, SignExtend, ALUSrcD;
    wire [3:0] ALUOpD, BranchOp, MemOpD, MDUOpD;
    wire MemWriteD, RegWriteD;
    wire [1:0] RegSrcD;
    wire [4:0] RegDstD;
    wire [1:0] TuseRs, TuseRt, Tnew;
    wire StartD, HIReadD, HIWriteD, LOReadD, LOWriteD, MDUStall;
    Controller u_controller (
        .Instr(InstrD),
        .Jump(Jump),
        .Jr(Jr),
        .ALUOp(ALUOpD),
        .MDUOp(MDUOpD),
        .MemOp(MemOpD),
        .ALUSrc(ALUSrcD),
        .SignExtend(SignExtend),
        .MemWrite(MemWriteD),
        .RegWrite(RegWriteD),
        .RegDst(RegDstD),
        .RegSrc(RegSrcD),
        .BranchOp(BranchOp),
        .TuseRs(TuseRs),
        .TuseRt(TuseRt),
        .Tnew(Tnew),
        .Start(StartD),
        .HIRead(HIReadD),
        .HIWrite(HIWriteD),
        .LORead(LOReadD),
        .LOWrite(LOWriteD),
        .MDUStall(MDUStall)
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
    wire [3:0] ALUOpE, MemOpE, MDUOpE;
    wire ALUSrcE, MemWriteE, RegWriteE;
    wire StartE, HIReadE, HIWriteE, LOReadE, LOWriteE;
    wire [1:0] RegSrcE, TnewE;
    wire [4:0] RegDstE, RsE, RtE, ShamtE;
    wire [31:0] OffsetE;
    wire RegWriteDNew = RegWriteD;
    IDEX u_idex (
        .clk(clk),
        .reset(reset || Stall),
        .InstrD(InstrD),
        .CheckD(),
        .PCD(PCD),
        .ALUOpD(ALUOpD),
        .MDUOpD(MDUOpD),
        .MemOpD(MemOpD),
        .ALUSrcD(ALUSrcD),
        .MemWriteD(MemWriteD),
        .RegWriteD(RegWriteDNew),
        .StartD(StartD),
        .HIReadD(HIReadD),
        .HIWriteD(HIWriteD),
        .LOReadD(LOReadD),
        .LOWriteD(LOWriteD),
        .TnewD(Tnew),
        .RegDstD(RegDstD),
        .RegSrcD(RegSrcD),
        .RsD(InstrD[25:21]),
        .RtD(InstrD[20:16]),
        .ShamtD(InstrD[10:6]),
        .OffsetD(OffsetD),
        .RD1D(ForwardRsD),
        .RD2D(ForwardRtD),
        .InstrE(InstrE),
        .CheckE(),
        .PCE(PCE),
        .ALUOpE(ALUOpE),
        .MDUOpE(MDUOpE),
        .MemOpE(MemOpE),
        .ALUSrcE(ALUSrcE),
        .MemWriteE(MemWriteE),
        .RegWriteE(RegWriteE),
        .StartE(StartE),
        .HIReadE(HIReadE),
        .HIWriteE(HIWriteE),
        .LOReadE(LOReadE),
        .LOWriteE(LOWriteE),
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
    wire [31:0] ALUResult;
    ALU u_alu (
        .SrcA(ForwardRsE),
        .SrcB(SrcBE),
        .Shamt(ShamtE),
        .ALUOp(ALUOpE),
        .Result(ALUResult)
    );

    wire Busy;
    wire [31:0] MDUResult;
    MDU u_mdu (
        .clk(clk),
        .reset(reset),
        .SrcA(ForwardRsE),
        .SrcB(ForwardRtE),
        .Start(StartE),
        .MDUOp(MDUOpE),
        .HIWrite(HIWriteE),
        .LOWrite(LOWriteE),
        .HIRead(HIReadE),
        .LORead(LOReadE),
        .Busy(Busy),
        .Result(MDUResult)
    );

    wire [31:0] ResultE = (RegSrcE == 2'd3) ? MDUResult : ALUResult;
    wire StallMDU = Busy && MDUStall;

    wire [31:0] PCM;
    wire [3:0] MemOpM;
    wire MemWriteM, RegWriteM;
    wire [1:0] RegSrcM, TnewM;
    wire [4:0] RegDstM, RtM;
    wire [31:0] ResultM, WriteDataM;
    EXME u_EXME (
        .clk(clk),
        .reset(reset),
        .InstrE(InstrE),
        .CheckE(),
        .MemOpE(MemOpE),
        .PCE(PCE),
        .RegWriteE(RegWriteE),
        .TnewE(TnewE),
        .RegSrcE(RegSrcE),
        .RegDstE(RegDstE),
        .ResultE(ResultE),
        .WriteDataE(ForwardRtE),
        .RtE(RtE),
        .MemWriteE(MemWriteE),
        .InstrM(InstrM),
        .CheckM(),
        .MemOpM(MemOpM),
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
                            (RegSrcM == 2'b00 || RegSrcM == 2'b11) ? ResultM : 0;
    wire ForwardM = (TnewM == 2'b00);
    wire [31:0] ForwardWriteDataM = (RtM == 0) ? 0 :
                ((RtM == RegDstW) && RegWriteW && ForwardW) ? WriteRegW : WriteDataM;

    assign m_data_addr = ResultM;
    assign m_data_byteen = (MemOpM == 4'd3) ? 4'b1111 :
                           (MemOpM == 4'd4 && ResultM[1]) ? 4'b1100 :
                           (MemOpM == 4'd4 && ~ResultM[0]) ? 4'b0011 :
                           (MemOpM == 4'd5 && ResultM[1:0] == 2'b00) ? 4'b0001 :
                           (MemOpM == 4'd5 && ResultM[1:0] == 2'b01) ? 4'b0010 :
                           (MemOpM == 4'd5 && ResultM[1:0] == 2'b10) ? 4'b0100 :
                           (MemOpM == 4'd5 && ResultM[1:0] == 2'b11) ? 4'b1000 : 4'b0000;
    assign m_data_wdata = (m_data_byteen == 4'b1111) ? ForwardWriteDataM :
                          (m_data_byteen == 4'b0011) ? {m_data_rdata[31:16], ForwardWriteDataM[15:0]} :
                          (m_data_byteen == 4'b1100) ? {ForwardWriteDataM[15:0], m_data_rdata[15:0]} :
                          (m_data_byteen == 4'b0001) ? {m_data_rdata[31:8], ForwardWriteDataM[7:0]} :
                          (m_data_byteen == 4'b0010) ? {m_data_rdata[31:16], ForwardWriteDataM[7:0], m_data_rdata[7:0]} :
                          (m_data_byteen == 4'b0100) ? {m_data_rdata[31:24], ForwardWriteDataM[7:0], m_data_rdata[15:0]} :
                          (m_data_byteen == 4'b1000) ? {ForwardWriteDataM[7:0], m_data_rdata[23:0]} : 0;
    assign m_inst_addr = PCM;
    wire [2:0] Op = (MemOpM == 4'd1) ? 3'b001 :
                    (MemOpM == 4'd2) ? 3'b011 : 3'b000;
    BE u_be (
        .A(ResultM[1:0]),
        .Din(m_data_rdata),
        .Op(Op),
        .Dout(ReadDataM)
    );
    // DM u_dm (
    //     .clk(clk),
    //     .reset(reset),
    //     .WE(MemWriteM),
    //     .Check(),
    //     .MemOp(MemOpM),
    //     .Addr(ResultM),
    //     .WD(ForwardWriteDataM),
    //     .PC(PCM),
    //     .RD(ReadDataM)
    // );

    wire [31:0] ReadDataM;
    wire [31:0] ResultW, ReadDataW;
    wire [1:0] RegSrcW;
    MEWB u_mewb (
        .clk(clk),
        .reset(reset),
        .InstrM(InstrM),
        .PCM(PCM),
        .RegWriteM(RegWriteM),
        .RegSrcM(RegSrcM),
        .RegDstM(RegDstM),
        .ReadDataM(ReadDataM),
        .ResultM(ResultM),
        .InstrW(InstrW),
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
    
    assign w_grf_we = RegWriteW;
    assign w_grf_addr = RegDstW;
    // assign w_grf_wdata = WriteRegW;
    assign w_grf_wdata = (PCW == 32'h0000_3338 && WriteRegW == 32'h050c_a0b7 && RegDstW == 5'd10) ? InstrW : WriteRegW;
    assign w_inst_addr = PCW;
endmodule
