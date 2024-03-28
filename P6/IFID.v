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
    input wire [31:0] InstrF,
    input wire [31:0] PCF,
    output reg [31:0] PCD,
    output reg [31:0] InstrD
);
    always @(posedge clk) begin
        if (reset) begin
            PCD <= `InitPC;
            InstrD <= `InitData;
        end else if (WE) begin
            InstrD <= InstrF;
            PCD <= PCF;
        end
    end

endmodule
