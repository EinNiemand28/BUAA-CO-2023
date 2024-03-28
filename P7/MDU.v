`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:42:52 11/24/2023 
// Design Name: 
// Module Name:    MDU 
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
`define Mult 4'd0
`define Multu 4'd1
`define Div 4'd2
`define Divu 4'd3
module MDU (
    input wire clk,
    input wire reset,
    input wire Req,
    input wire [31:0] SrcA,
    input wire [31:0] SrcB,
    input wire Start,
    input wire [3:0] MDUOp,
    input wire HIWrite,
    input wire LOWrite,
    input wire HIRead,
    input wire LORead,
    output wire Busy,
    output wire [31:0] Result
    // output reg [4:0] cnt
);
    reg [31:0] RegHI, RegLO;
    reg [31:0] HI, LO;
    reg [4:0] cnt;
    initial begin
        HI = 0;
        LO = 0;
        RegHI = 0;
        RegLO = 0;
        cnt = 0;
    end
    always @(posedge clk) begin
        if (reset) begin
            HI <= 0;
            LO <= 0;
            RegHI <= 0;
            RegLO <= 0;
            cnt <= 0;
        end else if (!Req) begin
            if (Start) begin
                case (MDUOp)
                    `Mult: begin
                        {RegHI, RegLO} <= $signed(SrcA) * $signed(SrcB);
                        cnt <= 5;
                    end
                    `Multu: begin
                        {RegHI, RegLO} <= SrcA * SrcB;
                        cnt <= 5;
                    end
                    `Div: begin
                        RegLO <= $signed(SrcA) / $signed(SrcB);
                        RegHI <= $signed(SrcA) % $signed(SrcB);
                        cnt <= 10;
                    end
                    `Divu: begin
                        RegLO <= SrcA / SrcB;
                        RegHI <= SrcA % SrcB;
                        cnt <= 10;
                    end
                endcase
            end else if (HIWrite) begin
                HI <= SrcA;
            end else if (LOWrite) begin
                LO <= SrcA;
            end else if (cnt != 0) begin
                if (cnt == 5'd1) begin
                    HI <= RegHI;
                    LO <= RegLO;
                end
                cnt <= cnt - 1;
            end
        end
        
    end
    assign Busy = (Start || cnt != 0) ? 1'b1 : 1'b0;
    assign Result = (HIRead) ? HI :
                    (LORead) ? LO : 0;

endmodule
