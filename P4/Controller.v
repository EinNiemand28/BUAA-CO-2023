`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:56:47 11/03/2023 
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
    input wire [5:0] op,
    input wire [5:0] funct,
    output wire [1:0] RegDst,
    output wire Jump,
    output wire Jr,
    output wire [2:0] BranchOp,
    output wire [1:0] RegSrc,
    output wire RegWrite,
    output wire MemWrite,
    output wire SignExtend,
    output wire ALUSrc,
    output wire [2:0] ALUOp,
    output wire [2:0] MemOp
);
    wire R = (op == 6'b00_0000);
    wire add, sub, sll, jr;
    wire ori, lui;
    wire beq, bne, bgtz, blez, bgez_bltz;
    wire lw, lh, lhu, lb, lbu, sw, sh, sb;
    wire jal, j;
    
    assign add = R & (funct == 6'b10_0000);
    assign sub = R & (funct == 6'b10_0010);
    assign sll = R & (funct == 6'b00_0000);
    assign jr = R & (funct == 6'b00_1000);

    assign ori = (op == 6'b00_1101);
    assign lui = (op == 6'b00_1111);

    assign beq = (op == 6'b00_0100);
    assign bne = (op == 6'b00_0101);
    assign bgtz = (op == 6'b00_0111);
    assign blez = (op == 6'b00_0110);
    assign bgez_bltz = (op == 6'b00_0001);
    
    assign lw = (op == 6'b10_0011);
    assign lh = (op == 6'b10_0001);
    assign lhu = (op == 6'b10_0101);
    assign lb = (op == 6'b10_0000);
    assign lbu = (op == 6'b10_0100);
    assign sw = (op == 6'b10_1011);
    assign sh = (op == 6'b10_1001);
    assign sb = (op == 6'b10_1000);

    assign jal = (op == 6'b00_0011);
    assign j = (op == 6'b00_0010);

    assign RegDst = jal ? 2'b10 :
                    R ? 2'b00 : 2'b01;
    assign Jump = jal | j;
    assign Jr = jr;
    assign BranchOp = bgez_bltz ? 3'd1 :
                      bgtz ? 3'd2 :
                      blez ? 3'd3 :
                      bne ? 3'd4 :
                      beq ? 3'd5 : 3'd0;
    assign RegSrc = jal ? 2'b10 :
                    (lw | lh | lhu | lb | lbu) ? 2'b01 : 2'b00;
    assign RegWrite = add | sub | ori | lui | sll | 
                      lw | lh | lhu | lb | lbu |
                      jal;
    assign MemWrite = sw | sh | sb;
    assign SignExtend = lw | lh | lhu | lb | lbu | sw | sh | sb |
                        beq | bne | blez | bgtz | bgez_bltz;
    assign ALUSrc = lw | lh | lhu | lb | lbu | sw | sh | sb |
                    ori | lui;
    assign ALUOp = sub ? 3'd1 :
                   ori ? 3'd3 :
                   sll ? 3'd4 :
                   lui ? 3'd5 : 3'd0;
    assign MemOp = lh ? 3'd1 :
                   lhu ? 3'd2 :
                   lb ? 3'd3 :
                   lbu ? 3'd4 :
                   sw ? 3'd5 :
                   sh ? 3'd6 :
                   sb ? 3'd7 : 3'd0;
    
endmodule
