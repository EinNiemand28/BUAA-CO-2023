`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:10:12 11/02/2023 
// Design Name: 
// Module Name:    IFU 
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
module IFU (
    input wire reset,
    input wire clk,
    input wire [31:0] NextPC,
    output reg [31:0] PC,
    output wire [31:0] Instr
);
    reg [31:0] IM [0:4095];
    wire [31:0] pc;
    initial begin
        $readmemh("code.txt", IM);
        PC = `InitPC;
    end
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            PC <= `InitPC;
        end else begin
            PC <= NextPC;
        end
    end
    assign pc = PC - `InitPC;
    assign Instr = IM[pc[13:2]];

endmodule
