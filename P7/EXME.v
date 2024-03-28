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
    input wire Req,
    input wire [3:0] MemOpE,
    input wire [31:0] PCE,
    input wire RegWriteE,
    input wire [1:0] TnewE,
    input wire [2:0] RegSrcE,
    input wire [4:0] RegDstE,
    input wire [31:0] ResultE,
    input wire [31:0] WriteDataE,
    input wire [4:0] RtE,
    input wire [4:0] RdE,
    input wire MemWriteE,
    input wire [4:0] ExcCodeE,
    input wire CP0WriteE,
    input wire ExcDMOvE,
    input wire BDInE,
    input wire EretE,
    output reg [3:0] MemOpM,
    output reg [31:0] PCM,
    output reg RegWriteM,
    output reg [1:0] TnewM,
    output reg [2:0] RegSrcM,
    output reg [4:0] RegDstM,
    output reg [31:0] ResultM,
    output reg [31:0] WriteDataM,
    output reg [4:0] RtM,
    output reg [4:0] RdM,
    output reg MemWriteM,
    output reg [4:0] ExcCodeM,
    output reg CP0WriteM,
    output reg ExcDMOvM,
    output reg BDInM,
    output reg EretM
);
    always @(posedge clk) begin
        if (reset || Req) begin
            MemOpM <= 0;
            PCM <= (Req) ? 32'h0000_4180 : 0;
            RegWriteM <= 0;
            TnewM <= 0;
            RegSrcM <= 0;
            RegDstM <= 0;
            ResultM <= 0;
            WriteDataM <= 0;
            RtM <= 0;
            RdM <= 0;
            MemWriteM <= 0;
            ExcCodeM <= 0;
            CP0WriteM <= 0;
            ExcDMOvM <= 0;
            BDInM <= 0;
            EretM <= 0;
        end else begin
            MemOpM <= MemOpE;
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
            RdM <= RdE;
            MemWriteM <= MemWriteE;
            ExcCodeM <= ExcCodeE;
            CP0WriteM <= CP0WriteE;
            ExcDMOvM <= ExcDMOvE;
            BDInM <= BDInE;
            EretM <= EretE;
        end
    end

endmodule
