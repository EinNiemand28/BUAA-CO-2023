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
    output wire [2:0] ALUOp,
    output wire SignExtend,
    output wire MemWrite,
    output wire RegWrite,
    output wire [4:0] RegDst,
    output wire [1:0] RegSrc,
    output wire ALUSrc,
    output wire [4:0] BranchOp,
    output wire [1:0] TuseRs,
    output wire [1:0] TuseRt,
    output wire [1:0] Tnew
);
    wire [5:0] op = Instr[31:26];
    wire [5:0] funct = Instr[5:0];

    wire R = (op == 6'b00_0000);
    wire Addu, Subu, Sll;
    wire Ori, Lui;
    wire Beq, Bgez_Bltz, Bne;
    wire Lw, Sw;
    wire Jal, J;

    assign Addu = R && (funct == 6'b10_0000);
    assign Subu = R && (funct == 6'b10_0010);
    //zero
    assign Sll = R && (funct == 6'b00_0000);
    assign Jr = R && (funct == 6'b00_1000);

    assign Ori = (op == 6'b00_1101);
    assign Lui = (op == 6'b00_1111);

    assign Beq = (op == 6'b00_0100);
    assign Bgez_Bltz = (op == 6'b00_0001);

    assign Lw = (op == 6'b10_0011);
    assign Sw = (op == 6'b10_1011);

    assign Jal = (op == 6'b00_0011);
    assign J = (op == 6'b00_0010);
    //--------- decode ---------
    assign RegDst = Jal ? 5'h1f :
                    R ? Instr[15:11] : Instr[20:16];
    assign RegSrc = Jal ? 2'b10 :
                    Lw ? 2'b01 : 2'b00;
    assign MemWrite = Sw;
    assign RegWrite = Addu || Subu || Ori || Lui || Sll ||
                      Lw ||
                      Jal;
    assign Jump = Jal || J;
    assign SignExtend = Lw || Sw || 
                        Beq || Bgez_Bltz;
    assign ALUSrc = Lw || Sw ||
                    Ori || Lui;
    assign ALUOp = Subu ? 3'd1 :
                   Ori ? 3'd3 :
                   Sll ? 3'd4 :
                   Lui ? 3'd5 : 3'd0;
    assign BranchOp = Bgez_Bltz ? 5'd1 :
                      Beq ? 5'd2 : 5'd0;
    assign TuseRs = (Addu || Subu || Sll || Ori || Lui ||
                     Lw ||
                     Sw) ? 2'b01 : 
                    (Jr || (BranchOp != 0)) ? 2'b00 : 2'b11;
    assign TuseRt = (Sw) ? 2'b10 :
                    (Addu || Subu || Sll) ? 2'b01 :
                    (BranchOp != 0) ? 2'b00 : 2'b11;
    assign Tnew = (Lw) ? 2'b10 :
                  (Addu || Subu || Ori || Sll || Lui) ? 2'b01 : 2'b00;

endmodule
