`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:00:56 10/16/2023 
// Design Name: 
// Module Name:    dotProduct 
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
module dotProduct(
	input [31:0] vector_a, 
	input [31:0] vector_b,
	output reg [5:0] result
    );
	
	integer i;
	always @(vector_a, vector_b) begin
		result = 0;
		for (i = 0; i < 6'd32; i = i + 1) begin
			if ((vector_a[i] & vector_b[i]) == 1'b1) begin
				result = result + 6'b1;
			end
			else begin
				result = result;
			end
		end
	end

endmodule
