`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:04:17 11/03/2023 
// Design Name: 
// Module Name:    GRF 
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
module GRF (
    input wire clk,
    input wire reset,
    input wire WE,
    input wire [4:0] A1,
    input wire [4:0] A2,
    input wire [4:0] A3,
    input wire [31:0] WD,
    input wire [31:0] PC,
    output wire [31:0] RD1,
    output wire [31:0] RD2
);
    reg [31:0] grf[0:31];
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            grf[i] = `InitData;
        end
    end
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            for (i = 0; i < 32; i = i + 1) begin
                grf[i] <= `InitData;
            end
        end else begin
            if (A3 == 5'b00000) begin
                grf[A3] <= `InitData;
            end else begin
                if (WE) begin
                  $display("@%h: $%d <= %h", PC, A3, WD);
                    grf[A3] <= WD;  
                end else begin
                    grf[A3] <= grf[A3];
                end
            end
        end
    end
    assign RD1 = grf[A1];
    assign RD2 = grf[A2];
endmodule
