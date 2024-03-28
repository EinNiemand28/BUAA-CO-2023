`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:06:11 11/11/2023 
// Design Name: 
// Module Name:    MEWB 
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
module MEWB (
    input wire clk,
    input wire reset,
    input wire Req,
    input wire [31:0] PCM,
    input wire RegWriteM,
    input wire [2:0] RegSrcM,
    input wire [31:0] DataToRegM,
    input wire [31:0] ResultM,
    input wire [4:0] RegDstM,
    output reg [31:0] PCW,
    output reg RegWriteW,
    output reg [2:0] RegSrcW,
    output reg [31:0] DataToRegW,
    output reg [31:0] ResultW,
    output reg [4:0] RegDstW
);
    always @(posedge clk) begin
        if (reset || Req) begin
            PCW <= (Req) ? 32'h0000_4180 : 0;
            RegWriteW <= 0;
            RegSrcW <= 0;
            DataToRegW <= 0;
            ResultW <= 0;
            RegDstW <= 0;
        end else begin
            PCW <= PCM;
            RegWriteW <= RegWriteM;
            RegSrcW <= RegSrcM;
            DataToRegW <= DataToRegM;
            ResultW <= ResultM;
            RegDstW <= RegDstM;
        end
    end

endmodule
