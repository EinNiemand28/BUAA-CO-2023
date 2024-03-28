`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:05:29 11/11/2023 
// Design Name: 
// Module Name:    IDEX 
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
// `define InitData 32'h0000_0000
// `define InitPC 32'h0000_3000
module IDEX (
    input wire clk,
    input wire reset,
    input wire CheckD,
    input wire [31:0] PCD,
    input wire [2:0] ALUOpD,
    input wire ALUSrcD,
    input wire MemWriteD,
    input wire RegWriteD,
    input wire [1:0] TnewD,
    input wire [4:0] RegDstD,
    input wire [1:0] RegSrcD,
    input wire [4:0] RsD,
    input wire [4:0] RtD,
    input wire [4:0] ShamtD,
    input wire [31:0] OffsetD,
    input wire [31:0] RD1D,
    input wire [31:0] RD2D,
    output reg CheckE,
    output reg [31:0] PCE,
    output reg [2:0] ALUOpE,
    output reg ALUSrcE,
    output reg MemWriteE,
    output reg RegWriteE,
    output reg [1:0] TnewE,
    output reg [4:0] RegDstE,
    output reg [1:0] RegSrcE,
    output reg [4:0] RsE,
    output reg [4:0] RtE,
    output reg [4:0] ShamtE,
    output reg [31:0] OffsetE,
    output reg [31:0] RD1E,
    output reg [31:0] RD2E
);
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            CheckE <= 0;
            PCE <= 0;
            ALUOpE <= 0;
            ALUSrcE <= 0;
            MemWriteE <= 0;
            RegWriteE <= 0;
            TnewE <= 0;
            RegDstE <= 0;
            RegSrcE <= 0;
            RsE <= 0;
            RtE <= 0;
            ShamtE <= 0;
            OffsetE <= 0;
            RD1E <= 0;
            RD2E <= 0;
        end else begin
            CheckE <= CheckD;
            PCE <= PCD;
            ALUOpE <= ALUOpD;
            ALUSrcE <= ALUSrcD;
            MemWriteE <= MemWriteD;
            RegWriteE <= RegWriteD;
            TnewE <= TnewD;
            RegDstE <= RegDstD;
            RegSrcE <= RegSrcD;
            RsE <= RsD;
            RtE <= RtD;
            ShamtE <= ShamtD;
            RD1E <= RD1D;
            RD2E <= RD2D;
            OffsetE <= OffsetD;
        end
    end

endmodule
