`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:27:42 10/16/2023 
// Design Name: 
// Module Name:    coloring 
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
module coloring(
	input clk,
	input rst_n,
	input [1:0] color,
	output  check,
	output reg [1:0] cnt,
	output reg [3:0] st
    );
	
	reg flag;
	assign check = (flag == 1'b1) ? 1'b1 : 1'b0;
	 
	always @ (posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			flag <= 1'b0;
			st <= 4'b0;
			cnt <= 2'b0;
		end
		else begin
			if (st[3:2] == st[1:0] && st[1:0] == color && cnt >= 2'b10) begin
				st <= st;
				flag <= 1'b1;
			end
			else if (((st[1:0] == 2'b00 && color == 2'b01) || (st[1:0] == 2'b01 && color == 2'b00)) && cnt >= 2'b01 ) begin
				st <= st;
				flag <= 1'b1;
			end
			else begin
				st <= {st[1:0], color};
				flag <= 1'b0;
				if (cnt == 2'b11) begin
					cnt <= cnt;
				end
				else begin
					cnt <= cnt + 2'b01;
				end
			end
		end
	end
endmodule
