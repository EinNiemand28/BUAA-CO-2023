`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:48:34 11/24/2023 
// Design Name: 
// Module Name:    BE 
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
module BE (
    input wire [1:0] A,
    input wire [31:0] Din,
    input wire [2:0] Op,
    output wire [31:0] Dout
);
    wire [7:0] B = (A == 2'b00) ? Din[7:0] :
                   (A == 2'b01) ? Din[15:8] :
                   (A == 2'b10) ? Din[23:16] : Din[31:24];
    wire [15:0] H = (A[1] == 1'b1) ? Din[31:16] : Din[15:0];
    assign Dout = (Op == 3'b000) ? Din :
                  (Op == 3'b001) ? {{16{H[15]}}, H} :
                  (Op == 3'b010) ? {16'b0, H} :
                  (Op == 3'b011) ? {{24{B[7]}}, B} :
                  (Op == 3'b100) ? {24'b0, B} : Din;

endmodule
