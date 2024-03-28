`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:05:55 11/11/2023 
// Design Name: 
// Module Name:    EXME 
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
module EXME (
    input wire clk,
    input wire reset,
    input wire CheckE,
    input wire [31:0] PCE,
    input wire RegWriteE,
    input wire [1:0] TnewE,
    input wire [1:0] RegSrcE,
    input wire [4:0] RegDstE,
    input wire [31:0] ResultE,
    input wire [31:0] WriteDataE,
    input wire [4:0] RtE,
    input wire MemWriteE,
    output reg CheckM,
    output reg [31:0] PCM,
    output reg RegWriteM,
    output reg [1:0] TnewM,
    output reg [1:0] RegSrcM,
    output reg [4:0] RegDstM,
    output reg [31:0] ResultM,
    output reg [31:0] WriteDataM,
    output reg [4:0] RtM,
    output reg MemWriteM
);
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            CheckM <= 0;
            PCM <= 0;
            RegWriteM <= 0;
            TnewM <= 0;
            RegSrcM <= 0;
            RegDstM <= 0;
            ResultM <= 0;
            WriteDataM <= 0;
            RtM <= 0;
            MemWriteM <= 0;
        end else begin
            CheckM <= CheckE;
            PCM <= PCE;
            RegWriteM <= RegWriteE;
            if (TnewE == 2'b00) begin
                TnewM <= 2'b00;
            end else begin
                TnewM <= TnewE - 1;
            end
            RegSrcM <= RegSrcE;
            RegDstM <= RegDstE;
            ResultM <= ResultE;
            WriteDataM <= WriteDataE;
            RtM <= RtE;
            MemWriteM <= MemWriteE;
        end
    end

endmodule
