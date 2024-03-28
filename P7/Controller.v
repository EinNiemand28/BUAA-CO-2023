`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:11:03 11/11/2023 
// Design Name: 
// Module Name:    Controller 
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
module Controller (
    input wire [31:0] Instr,
    output wire Jump,
    output wire Jr,
    output wire [3:0] ALUOp,
    output wire [3:0] MDUOp,
    output wire [3:0] MemOp,
    output wire SignExtend,
    output wire MemWrite,
    output wire RegWrite,
    output wire [4:0] RegDst,
    output wire [2:0] RegSrc,
    output wire ALUSrc,
    output wire [3:0] BranchOp,
    output wire [1:0] TuseRs,
    output wire [1:0] TuseRt,
    output wire [1:0] Tnew,
    output wire Start,
    output wire HIRead,
    output wire HIWrite,
    output wire LORead,
    output wire LOWrite,
    output wire MDUStall,
    output wire Eret,
    output wire CP0Write,
    output wire ALUOv,
    output wire DMOv,
    output wire ExcRI,
    output wire ExcSys,
    output wire DelayBranching
);
    wire [5:0] op = Instr[31:26];
    wire [5:0] funct = Instr[5:0];

    wire R = (op == 6'b00_0000);
    wire Add, Sub, And, Or, Sll, Slt, Sltu;
    wire Addi, Andi, Ori, Lui;
    wire Beq, Bgez_Bltz, Bne;
    wire Lb, Lh, Lw, Sb, Sh, Sw;
    wire Jal, J;
    wire Mult, Multu, Div, Divu;
    wire Mfhi, Mflo, Mthi, Mtlo;
    wire Mfc0, Mtc0, Syscall;

    assign Add = R && (funct == 6'b10_0000);
    assign Sub = R && (funct == 6'b10_0010);
    assign And = R && (funct == 6'b10_0100);
    assign Or = R && (funct == 6'b10_0101);
    assign Sll = R && (funct == 6'b00_0000);
    assign Slt = R && (funct == 6'b10_1010);
    assign Sltu = R && (funct == 6'b10_1011);
    assign Jr = R && (funct == 6'b00_1000);

    assign Addi = (op == 6'b00_1000);
    assign Andi = (op == 6'b00_1100);
    assign Ori = (op == 6'b00_1101);
    assign Lui = (op == 6'b00_1111);

    assign Beq = (op == 6'b00_0100);
    assign Bgez_Bltz = (op == 6'b00_0001);
    assign Bne = (op == 6'b00_0101);

    assign Lb = (op == 6'b10_0000);
    assign Lh = (op == 6'b10_0001);
    assign Lw = (op == 6'b10_0011);
    assign Sb = (op == 6'b10_1000);
    assign Sh = (op == 6'b10_1001);
    assign Sw = (op == 6'b10_1011);

    assign Jal = (op == 6'b00_0011);
    assign J = (op == 6'b00_0010);

    assign Mult = R && (funct == 6'b01_1000);
    assign Multu = R && (funct == 6'b01_1001);
    assign Div = R && (funct == 6'b01_1010);
    assign Divu = R && (funct == 6'b01_1011);

    assign Mfhi = R && (funct == 6'b01_0000);
    assign Mflo = R && (funct == 6'b01_0010);
    assign Mthi = R && (funct == 6'b01_0001);
    assign Mtlo = R && (funct == 6'b01_0011);

    assign Mfc0 = (op == 6'b01_0000) && (Instr[25:21] == 5'b0_0000);
    assign Mtc0 = (op == 6'b01_0000) && (Instr[25:21] == 5'b0_0100);
    assign Eret = (Instr == 32'b010000_1000_0000_0000_0000_0000_011000);
    assign Syscall = R && (funct == 6'b00_1100);
    //--------- decode ---------
    assign RegDst = Jal ? 5'h1f :
                    R ? Instr[15:11] : Instr[20:16];
    assign RegSrc = Mfc0 ? 3'b100 :
                    (Mfhi || Mflo) ? 3'b011 :
                    Jal ? 3'b010 :
                    (Lw || Lh || Lb) ? 3'b001 : 3'b000;
    assign MemWrite = Sb || Sh || Sw;
    assign RegWrite = Add || Sub || And || Or || Sll || Slt || Sltu ||
                      Addi || Andi || Ori || Lui ||
                      Lb || Lh || Lw ||
                      Mfhi || Mflo ||
                      Jal ||
                      Mfc0;
    assign Jump = Jal || J;
    assign SignExtend = Addi ||
                        Lb || Lh || Lw || Sb || Sh || Sw || 
                        Beq || Bgez_Bltz || Bne;
    assign ALUSrc = Lb || Lh || Lw || Sb || Sh || Sw ||
                    Addi || Andi || Ori || Lui;
    assign ALUOp = Sub ? 4'd1 :
                   (And || Andi) ? 4'd2 :
                   (Or || Ori) ? 4'd3 :
                   Sll ? 4'd4 :
                   Lui ? 4'd5 : 
                   Slt ? 4'd6 :
                   Sltu ? 4'd7 : 4'd0;
    assign MDUOp = Multu ? 4'd1 :
                   Div ? 4'd2 :
                   Divu ? 4'd3 : 4'd0;
    assign MemOp = Lw ? 4'd1 :
                   Lh ? 4'd2 :
                   Lb ? 4'd3 :
                   Sw ? 4'd4 :
                   Sh ? 4'd5 :
                   Sb ? 4'd6 : 4'd0;
    assign BranchOp = Bgez_Bltz ? 4'd1 :
                      Beq ? 4'd2 : 
                      Bne ? 4'd3 : 4'd0;

    assign TuseRs = (Add || Sub || And || Or || Sll || Slt || Sltu ||
                     Addi || Andi || Ori || Lui ||
                     Mult || Multu || Div || Divu ||
                     Mthi || Mtlo ||
                     Lb || Lh || Lw ||
                     Sb || Sh || Sw) ? 2'b01 : 
                    (Jr || (BranchOp != 0)) ? 2'b00 : 2'b11;
    assign TuseRt = (Sb || Sh || Sw || Mtc0) ? 2'b10 :
                    (Add || Sub || And || Or || Sll || Slt || Sltu ||
                     Mult || Multu || Div || Divu) ? 2'b01 :
                    (BranchOp != 0) ? 2'b00 : 2'b11;
    assign Tnew = (Lb || Lh || Lw || Mfc0) ? 2'b10 :
                  (Add || Sub || And || Or || Sll || Slt || Sltu ||
                   Addi || Andi || Ori || Lui ||
                   Mfhi || Mflo) ? 2'b01 : 2'b00;

    assign Start = Mult || Multu || Div || Divu;
    assign HIRead = Mfhi;
    assign HIWrite = Mthi;
    assign LORead = Mflo;
    assign LOWrite = Mtlo;
    assign MDUStall = Mult || Multu || Div || Divu ||
                      Mfhi || Mflo || Mthi || Mtlo;

    assign CP0Write = Mtc0;
    assign ALUOv = Add || Sub || Addi;
    assign DMOv = Lw || Lh || Lb ||
                  Sw || Sh || Sb;
    assign ExcRI = !(Add || Sub || And || Or || Sll || Slt || Sltu ||
                    Addi || Andi || Ori || Lui ||
                    Beq || Bgez_Bltz || Bne || 
                    Lb || Lh || Lw || Sb || Sh || Sw || 
                    Jal || J || Jr ||
                    Mult || Multu || Div || Divu ||
                    Mfhi || Mflo || Mthi || Mtlo ||
                    Mfc0 || Mtc0 || Eret || Syscall);
    assign ExcSys = Syscall;
    assign DelayBranching = Jal || J || Jr ||
                            Bne || Beq || Bgez_Bltz;

endmodule
