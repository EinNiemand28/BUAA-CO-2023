`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:27:53 10/15/2023
// Design Name:   string2
// Module Name:   D:/file/study/2023Autumn/computer_composition/experiment/P1/practice_after_class/P1_L7_expr/string2_tb.v
// Project Name:  P1_L7_expr
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: string2
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module string2_tb;

	// Inputs
	reg clk;
	reg clr;
	reg [7:0] in;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	string2 uut (
		.clk(clk), 
		.clr(clr), 
		.in(in), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 1;
		in = 0;

		// Wait 100 ns for global reset to finish
		#10 clr = 0;
        // in = "1";
		// #10 in = "+";
		// #10 ;
		in = "(";
		#10 in = "1";
		#10 in = "+";
		#10 in = "2";
		#10 in = ")";
		#10 in = "*";
		#10 in = "(";
		#10 in = "3";
		#10 in = "+";
		#10 in = "1";
		#10 in = ")";
		#10 in = "+";
		#10 in = "1";
		#10 in = "+";
		#10 in = "2";
		#10 in = "+";
		#10 in = "(";
		#10 in = "2";
		#10 in = "+";
		#10 in = "3";
		#10 in = "+";
		#10 in = "4";
		#10 in = ")";
		#10 in = "+";
		#10 in = "(";
		#10 in = "2";
		#10 in = "+";
		#10 in = "3";
		#10 in = "+";
		#10 in = "4";
		#10 in = "(";
		#10 clr = 1;
		in = "1";
		#2 clr = 0;
		#8 in = "+";
		#10 in = "(";
		#10 in = "9";
		#10 in = ")";
		// Add stimulus here

	end
     always #5 clk = ~clk; 
endmodule

