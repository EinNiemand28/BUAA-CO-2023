`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:31:55 11/11/2023 
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
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                grf[i] <= `InitData;
            end
        end else begin
            if (A3 == 5'b0) begin
                grf[A3] <= `InitData;
            end else if (WE) begin
                // if (PC == 32'h0000_3338) begin
                //     $display("%d@%h-%h: $%d <= %h", $time, PC, Instr, A3, WD);
                // end
                grf[A3] <= WD;
            end
        end
    end
    assign RD1 = ((A1 == A3) && A3 && WE) ? WD : grf[A1];
    assign RD2 = ((A2 == A3) && A3 && WE) ? WD : grf[A2];

endmodule
