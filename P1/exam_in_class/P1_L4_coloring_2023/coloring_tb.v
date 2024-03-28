`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:58:42 10/19/2023
// Design Name:   coloring
// Module Name:   D:/file/study/2023Autumn/computer_composition/experiment/P1/exam_in_class/P1_L4_coloring_2023/coloring_tb.v
// Project Name:  P1_L4_coloring_2023
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: coloring
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module coloring_tb;

	// Inputs
	reg clk;
	reg rst_n;
	reg [1:0] color;

	// Outputs
	wire check;

	// Instantiate the Unit Under Test (UUT)
	coloring uut (
		.clk(clk), 
		.rst_n(rst_n), 
		.color(color), 
		.check(check)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst_n = 0;
		color = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

