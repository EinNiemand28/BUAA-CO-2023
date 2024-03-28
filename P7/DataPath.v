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
    input wire [5:0] HWInt,

    output wire [31:0] i_inst_addr,
    input wire [31:0] i_inst_rdata,
    
    output wire [31:0] m_data_addr,
    input wire [31:0] m_data_rdata,
    output wire [31:0] m_data_wdata,
    output wire [3:0] m_data_byteen,
    output wire [31:0] m_inst_addr,

    output wire w_grf_we,
    output wire [4:0] w_grf_addr,
    output wire [31:0] w_grf_wdata,
    output wire [31:0] w_inst_addr,

    output wire [31:0] macroscopic_pc
);
    wire [31:0] EPC;
    wire Req;

    wire [31:0] NextPC, PCF, PCF_temp;
    wire Stall = StallRsE || StallRtE || StallRsM || StallRtM || StallMDU || StallEret;
    // always @(posedge clk) begin
    //     $display("%d", Stall);
    // end
    IFU u_ifu (
        .clk(clk),
        .reset(reset),
        .WE(!Stall),
        .Req(Req),
        .NextPC(NextPC),
        .PC(PCF_temp)
    );
    assign PCF = Eret ? EPC : PCF_temp;
    wire ExcAdELF = ((| PCF[1:0]) || (PCF < 32'h0000_3000) || (PCF > 32'h0000_6ffc)) && !Eret;

    assign i_inst_addr = PCF;
    wire [31:0] InstrF = (ExcAdELF) ? 32'd0 : i_inst_rdata;

    wire [4:0] ExcCodeF = ExcAdELF ? 5'd4 : 5'd0;
    wire BDInF = DelayBranching;

    wire [31:0] InstrD;
    wire [31:0] PCD;
    wire [4:0] ExcCodeD_temp, ExcCodeD;
    wire BDInD;
    IFID u_ifid (
        .clk(clk),
        .reset(reset),
        // .reset(reset || (!Stall && BranhOp ==  && !Branch))
        .WE(!Stall),
        .Req(Req),
        .InstrF(InstrF),
        .PCF(PCF),
        .ExcCodeF(ExcCodeF),
        .BDInF(BDInF),
        .InstrD(InstrD),
        .PCD(PCD),
        .ExcCodeD(ExcCodeD_temp),
        .BDInD(BDInD)
    );

    wire Jump, Jr, SignExtend, ALUSrcD;
    wire [3:0] ALUOpD, BranchOp, MemOpD, MDUOpD;
    wire MemWriteD, RegWriteD;
    wire [2:0] RegSrcD;
    wire [4:0] RegDstD;
    wire [1:0] TuseRs, TuseRt, Tnew;
    wire StartD, HIReadD, HIWriteD, LOReadD, LOWriteD, MDUStall, Eret;
    wire CP0Write, ALUOv, DMOv, ExcRI, ExcSys;
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
        .MDUStall(MDUStall),
        .Eret(Eret),
        .CP0Write(CP0Write),
        .ALUOv(ALUOv),
        .DMOv(DMOv),
        .ExcRI(ExcRI),
        .ExcSys(ExcSys),
        .DelayBranching(DelayBranching)
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

    wire DelayBranching;
    NPC u_npc (
        .PCF(PCF),
        .PCD(PCD),
        .Instr26(InstrD[25:0]),
        .Offset(OffsetD),
        .RegToJump(ForwardRsD),
        .Jump(Jump),
        .Jr(Jr),
        .Branch(Branch),
        .Req(Req),
        .Eret(Eret),
        .EPC(EPC),
        .NextPC(NextPC)
    );

    assign ExcCodeD = ExcCodeD_temp ? ExcCodeD_temp :
                      ExcRI ? 5'd10 :
                      ExcSys ? 5'd8 : 5'd0;


    wire [31:0] PCE, RD1E, RD2E;
    wire [3:0] ALUOpE, MemOpE, MDUOpE;
    wire ALUSrcE, MemWriteE, RegWriteE;
    wire StartE, HIReadE, HIWriteE, LOReadE, LOWriteE;
    wire [2:0] RegSrcE;
    wire [1:0] TnewE;
    wire [4:0] RegDstE, RsE, RtE, RdE, ShamtE;
    wire [31:0] OffsetE;
    wire [4:0] ExcCodeE_temp, ExcCodeE;
    wire ALUOvE, DMOvE, BDInE, CP0WriteE, EretE;
    wire RegWriteDNew = RegWriteD;
    IDEX u_idex (
        .clk(clk),
        .reset(reset),
        .Req(Req),
        .Stall(Stall),
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
        .RdD(InstrD[15:11]),
        .ShamtD(InstrD[10:6]),
        .OffsetD(OffsetD),
        .RD1D(ForwardRsD),
        .RD2D(ForwardRtD),
        .ExcCodeD(ExcCodeD),
        .CP0WriteD(CP0Write),
        .ALUOvD(ALUOv),
        .DMOvD(DMOv),
        .BDInD(BDInD),
        .EretD(Eret),
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
        .RdE(RdE),
        .ShamtE(ShamtE),
        .OffsetE(OffsetE),
        .RD1E(RD1E),
        .RD2E(RD2E),
        .ExcCodeE(ExcCodeE_temp),
        .CP0WriteE(CP0WriteE),
        .ALUOvE(ALUOvE),
        .DMOvE(DMOvE),
        .BDInE(BDInE),
        .EretE(EretE)
    );

    wire StallRsE = (RegDstE != 0) && RegWriteE && (RegDstE == InstrD[25:21]) && (TuseRs < TnewE);
    wire StallRtE = (RegDstE != 0) && RegWriteE && (RegDstE == InstrD[20:16]) && (TuseRt < TnewE);
    wire [31:0] WriteRegE = (RegSrcE == 3'b010) ? PCE + 8 : 0;
    wire ForwardE = (TnewE == 2'b00);
    wire [31:0] ForwardRsE = (RsE == 0) ? 0 :
                ((RegDstM == RsE) && RegWriteM && ForwardM) ? WriteRegM : 
                ((RegDstW == RsE) && RegWriteW && ForwardW) ? WriteRegW : RD1E;
    wire [31:0] ForwardRtE = (RtE == 0) ? 0 :
                ((RegDstM == RtE) && RegWriteM && ForwardM) ? WriteRegM :
                ((RegDstW == RtE) && RegWriteW && ForwardW) ? WriteRegW : RD2E;
    wire [31:0] SrcBE = (ALUSrcE == 1'b1) ? OffsetE : ForwardRtE;
    wire [31:0] ALUResult;
    wire ExcOv, ExcDMOv;
    ALU u_alu (
        .SrcA(ForwardRsE),
        .SrcB(SrcBE),
        .ALUOv(ALUOvE),
        .DMOv(DMOvE),
        .Shamt(ShamtE),
        .ALUOp(ALUOpE),
        .Result(ALUResult),
        .ExcOv(ExcOv),
        .ExcDMOv(ExcDMOv)
    );

    wire Busy;
    wire [31:0] MDUResult;
    MDU u_mdu (
        .clk(clk),
        .reset(reset),
        .Req(Req),
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

    wire [31:0] ResultE = (RegSrcE == 3'd3) ? MDUResult : ALUResult;
    wire StallMDU = Busy && MDUStall;
    assign ExcCodeE = (ExcCodeE_temp) ? ExcCodeE_temp :
                      (ExcOv) ? 5'd12 : 5'd0;

    wire [31:0] PCM;
    wire [3:0] MemOpM;
    wire MemWriteM, RegWriteM;
    wire [2:0] RegSrcM;
    wire [1:0] TnewM;
    wire [4:0] RegDstM, RtM, RdM;
    wire [31:0] ResultM, WriteDataM;
    wire [4:0] ExcCodeM, ExcCodeM_temp;
    wire CP0WriteM, ExcDMOvM, BDInM, EretM;
    EXME u_EXME (
        .clk(clk),
        .reset(reset),
        .Req(Req),
        .MemOpE(MemOpE),
        .PCE(PCE),
        .RegWriteE(RegWriteE),
        .TnewE(TnewE),
        .RegSrcE(RegSrcE),
        .RegDstE(RegDstE),
        .ResultE(ResultE),
        .WriteDataE(ForwardRtE),
        .RtE(RtE),
        .RdE(RdE),
        .MemWriteE(MemWriteE),
        .ExcCodeE(ExcCodeE),
        .CP0WriteE(CP0WriteE),
        .ExcDMOvE(ExcDMOv),
        .BDInE(BDInE),
        .EretE(EretE),
        .MemOpM(MemOpM),
        .PCM(PCM),
        .RegWriteM(RegWriteM),
        .TnewM(TnewM),
        .RegSrcM(RegSrcM),
        .RegDstM(RegDstM),
        .ResultM(ResultM),
        .WriteDataM(WriteDataM),
        .RtM(RtM),
        .RdM(RdM),
        .MemWriteM(MemWriteM),
        .ExcCodeM(ExcCodeM_temp),
        .CP0WriteM(CP0WriteM),
        .ExcDMOvM(ExcDMOvM),
        .BDInM(BDInM),
        .EretM(EretM)
    );

    wire StallEret = (Eret) && ((CP0WriteE && RdE == 5'd14) || (CP0WriteM && RdM == 5'd14));
    wire StallRsM = (RegDstM != 0) && (RegDstM == InstrD[25:21]) && RegWriteM && (TuseRs < TnewM);
    wire StallRtM = (RegDstM != 0) && (RegDstM == InstrD[20:16]) && RegWriteM && (TuseRt < TnewM);
    wire [31:0] WriteRegM = (RegSrcM == 3'b010) ? PCM + 8 :
                            (RegSrcM == 3'b000 || RegSrcM == 3'b011) ? ResultM : 0;
    wire ForwardM = (TnewM == 2'b00);
    wire [31:0] ForwardWriteDataM = (RtM == 0) ? 0 :
                ((RtM == RegDstW) && RegWriteW && ForwardW) ? WriteRegW : WriteDataM;

    assign m_data_addr = ResultM;
    assign m_inst_addr = PCM;
    wire ExcAdES, ExcAdEL;
    BE u_be (
        .Req(Req),
        .MemOp(MemOpM),
        .Addr(m_data_addr),
        .ExcDMOv(ExcDMOvM),
        .WriteData(ForwardWriteDataM),
        .m_data_byteen(m_data_byteen),
        .m_data_wdata(m_data_wdata),
        .ExcAdES(ExcAdES)
    );
    
    wire [31:0] ReadData;
    DE u_de (
        .MemOp(MemOpM),
        .Addr(m_data_addr),
        .ExcDMOv(ExcDMOvM),
        .m_data_rdata(m_data_rdata),
        .ReadData(ReadData),
        .ExcAdEL(ExcAdEL)
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
    assign macroscopic_pc = PCM;
    assign ExcCodeM = (ExcCodeM_temp) ? ExcCodeM_temp :
                      (ExcAdEL) ? 5'd4 :
                      (ExcAdES) ? 5'd5 : 5'd0;

    wire [31:0] DataFromCP0;
    CP0 u_cp0 (
        .clk(clk),
        .reset(reset),
        .WE(CP0WriteM),
        .CP0Add(RdM),
        .CP0In(ForwardWriteDataM),
        .CP0Out(DataFromCP0),
        .VPC(PCM),
        .BDIn(BDInM),
        .ExcCodeIn(ExcCodeM),
        .HWInt(HWInt),
        .EXLClr(EretM),
        .EPCOut(EPC),
        .Req(Req)
    );

    wire [31:0] DataToRegM = (RegSrcM == 3'b100) ? DataFromCP0 : ReadData;
    wire [31:0] DataToRegW, ResultW;
    wire [2:0] RegSrcW;
    MEWB u_mewb (
        .clk(clk),
        .reset(reset),
        .Req(Req),
        .PCM(PCM),
        .RegWriteM(RegWriteM),
        .RegSrcM(RegSrcM),
        .RegDstM(RegDstM),
        .DataToRegM(DataToRegM),
        .ResultM(ResultM),
        .PCW(PCW),
        .RegWriteW(RegWriteW),
        .RegSrcW(RegSrcW),
        .RegDstW(RegDstW),
        .DataToRegW(DataToRegW),
        .ResultW(ResultW)
    );

    wire ForwardW = 1'b1;
    wire [31:0] WriteRegW = (RegSrcW == 3'b010) ? PCW + 8 :
                            (RegSrcW == 3'b001 || RegSrcW == 3'b100) ? DataToRegW : ResultW;
    
    assign w_grf_we = RegWriteW;
    assign w_grf_addr = RegDstW;
    assign w_grf_wdata = WriteRegW;
    assign w_inst_addr = PCW;
endmodule
