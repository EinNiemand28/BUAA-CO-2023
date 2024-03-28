`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:28:06 11/03/2023 
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
    input wire [31:0] Addr,
    input wire [31:0] WD,
    input wire [2:0] MemOp,
    input wire [31:0] PC,
    output wire [31:0] RD
);
    reg [31:0] DM [0:3071];
    wire [1:0] AimAddr;
    wire [31:0] ReadData;
    wire [31:0] WriteData;
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
                $display("@%h: *%h <= %h", PC, Addr, WD);
                DM[Addr[13:2]] <= WriteData;
            end else begin
                DM[Addr[13:2]] <= DM[Addr[13:2]];
            end
        end
    end
    assign AimAddr = Addr[1:0];
    assign ReadData = DM[Addr[13:2]];
    assign WriteData = (MemOp == 3'd6 && AimAddr[1] == 1'b0) ? {WD[15:0], ReadData[15:0]} :
                       (MemOp == 3'd6 && AimAddr[1] == 1'b1) ? {ReadData[31:16], WD[15:0]} :
                       //sh
                       (MemOp == 3'd7 && AimAddr == 2'b00) ? {ReadData[31:8], WD[7:0]} :
                       (MemOp == 3'd7 && AimAddr == 2'b01) ? {ReadData[31:16], WD[7:0], ReadData[7:0]} :
                       (MemOp == 3'd7 && AimAddr == 2'b10) ? {ReadData[31:24], WD[7:0], ReadData[15:0]} :
                       (MemOp == 3'd7 && AimAddr == 2'b11) ? {WD[7:0], ReadData[23:0]} : WD;//sw
                       //sb
    assign RD = (MemOp == 3'd1 && AimAddr[1] == 1'b0) ? {{16{ReadData[15]}}, ReadData[15:0]} :
                (MemOp == 3'd1 && AimAddr[1] == 1'b1) ? {{16{ReadData[31]}}, ReadData[31:16]} :
                //lh
                (MemOp == 3'd2 && AimAddr[1] == 1'b0) ? {16'b0, ReadData[15:0]} :
                (MemOp == 3'd2 && AimAddr[1] == 1'b1) ? {16'b0, ReadData[31:16]} :
                //lhu
                (MemOp == 3'd3 && AimAddr == 2'b00) ? {{24{ReadData[7]}}, ReadData[7:0]} :
                (MemOp == 3'd3 && AimAddr == 2'b01) ? {{24{ReadData[15]}}, ReadData[15:8]} :
                (MemOp == 3'd3 && AimAddr == 2'b10) ? {{24{ReadData[23]}}, ReadData[23:16]} :
                (MemOp == 3'd3 && AimAddr == 2'b11) ? {{24{ReadData[31]}}, ReadData[31:24]} :
                //lb
                (MemOp == 3'd4 && AimAddr == 2'b00) ? {24'b0, ReadData[7:0]} :
                (MemOp == 3'd4 && AimAddr == 2'b01) ? {24'b0, ReadData[15:8]} :
                (MemOp == 3'd4 && AimAddr == 2'b10) ? {24'b0, ReadData[23:16]} :
                (MemOp == 3'd4 && AimAddr == 2'b11) ? {24'b0, ReadData[31:24]} : ReadData;//lw
                //lbu
endmodule
