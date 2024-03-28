`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:37:15 11/03/2023 
// Design Name: 
// Module Name:    BranchControl 
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
`define Zero 32'h0000_0000
module BranchControl (
    input wire [2:0] BranchOp,
    input wire equal,
    input wire [31:0] rs,
    input wire Judge,
    output wire Branch
);
    assign Branch = ((BranchOp == 3'd1) & Judge & (rs >= `Zero)) |
                    ((BranchOp == 3'd1) & (~Judge) & (rs < `Zero)) |
                    ((BranchOp == 3'd2) & (rs > `Zero)) |
                    ((BranchOp == 3'd3) & (rs <= `Zero)) |
                    ((BranchOp == 3'd4) & (~equal)) |
                    ((BranchOp == 3'd5) & equal);

endmodule
