`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:44:17 11/11/2023 
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
    input wire clk,
    input wire reset,
    input wire WE,
    input wire Req,
    input wire [31:0] NextPC,
    output reg [31:0] PC
    // output wire [31:0] Instr
);
    // reg [31:0] IM[0:4095];
    // initial begin
        // $readmemh("../p5_testcode.txt", IM);
    //     $readmemh("code.txt", IM);
    //     PC = `InitPC;
    // end
    // integer i;
    always @(posedge clk) begin
        if (reset) begin
            // for (i = 0; i < 5; i = i + 1) begin
            //     $display("%d@%h", i, IM[i]);
            // end
            PC <= `InitPC;
        end else if (WE || Req) begin
            PC <= NextPC;
        end
    end
    // wire [31:0] pc = PC - `InitPC;
    // assign Instr = IM[pc[13:2]];

endmodule
