`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:56:14 11/11/2023 
// Design Name: 
// Module Name:    DM 
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
`define InitData 32'h0000_0000
module DM (
    input wire clk,
    input wire reset,
    input wire WE,
    input wire Check,
    input wire [31:0] Addr,
    input wire [31:0] WD,
    input wire [31:0] PC,
    output wire [31:0] RD,
    output wire condition
);
    reg [31:0] DM [0:3071];
    integer i;
    initial begin
        for (i = 0; i < 3072; i = i + 1) begin
            DM[i] = `InitData;
        end
    end

    always @(posedge clk) begin
        if (reset == 1'b1) begin
            for (i = 0; i < 3072; i = i + 1) begin
                DM[i] <= `InitData;
            end
        end else begin
            if (WE == 1'b1) begin
                DM[Addr[13:2]] <= WriteData;
                $display("%d@%h: *%h <= %h", $time, PC, Addr, WriteData);
            end else begin
                DM[Addr[13:2]] <= DM[Addr[13:2]];
            end
        end
    end
   wire [31:0] ReadData = DM[Addr[13:2]];
   wire [31:0] WriteData = WD;
   assign RD = ReadData;

endmodule
