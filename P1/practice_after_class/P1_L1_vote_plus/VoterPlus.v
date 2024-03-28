`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:18:14 10/15/2023 
// Design Name: 
// Module Name:    VoterPlus 
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
module VoterPlus (
    input clk,
    input reset,
    input [31:0] np,
    input [7:0] vip,
    input vvip,
    output reg [7:0] result
);

    reg [31:0] st_np;
    reg [7:0] st_vip;
    reg st_vvip;
    integer i;
    always @(*) begin
        result = 0;
        for (i = 0; i < 6'd32; i = i + 1) begin
            if (((st_np >> i) & 32'b1) == 32'b1) begin
                result = result + 8'b1;
            end
        end
        for (i = 0; i < 4'd8; i = i + 1) begin
            if (((st_vip >> i) & 8'b1) == 8'b1) begin
                result = result + 8'b100;
            end
        end
        if (st_vvip == 1'b1) begin
            result = result + 8'b10000;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            st_np   <= 32'b0;
            st_vip  <= 8'b0;
            st_vvip <= 1'b0;
        end else begin
            st_np   <= (st_np | np);
            st_vip  <= (st_vip | vip);
            st_vvip <= (st_vvip | vvip);
        end
    end
endmodule
