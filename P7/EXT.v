`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:42:22 11/11/2023 
// Design Name: 
// Module Name:    EXT 
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
module EXT (
    input wire [15:0] imm16,
    input wire ExtOp,
    output wire [31:0] imm32
);
    assign imm32 = (ExtOp == 1'b1) ? {{16{imm16[15]}}, imm16} :
                                     {16'b0, imm16};

endmodule
