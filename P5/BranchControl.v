`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:32:15 11/11/2023 
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
    input wire [31:0] rs,
    input wire [31:0] rt,
    input wire [4:0] BranchOp,
    input wire Judge,
    output wire Branch
);
    assign Branch = ((BranchOp == 5'd1) & Judge & ($signed(rs) >= `Zero)) |
                    ((BranchOp == 5'd1) & (!Judge) & ($signed(rs) < `Zero)) |
                    ((BranchOp == 5'd2) & (rs == rt));

endmodule
