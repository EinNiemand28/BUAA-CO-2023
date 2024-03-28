`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:04:40 11/11/2023 
// Design Name: 
// Module Name:    IFID 
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
`define InitPC 32'h0000_3000
`define InitData 32'h0000_0000
module IFID (
    input wire clk,
    input wire reset,
    input wire WE,
    input wire Req,
    input wire [31:0] InstrF,
    input wire [31:0] PCF,
    input wire [4:0] ExcCodeF,
    input wire BDInF,
    output reg [31:0] PCD,
    output reg [31:0] InstrD,
    output reg [4:0] ExcCodeD,
    output reg BDInD
);
    always @(posedge clk) begin
        if (reset || Req) begin
            PCD <= Req ? 32'h0000_4180 : `InitPC;
            InstrD <= `InitData;
            ExcCodeD <= 0;
            BDInD <= 0;
        end else if (WE) begin
            InstrD <= InstrF;
            PCD <= PCF;
            ExcCodeD <= ExcCodeF;
            BDInD <= BDInF;
        end
    end

endmodule
