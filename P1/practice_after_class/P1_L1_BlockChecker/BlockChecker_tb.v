`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:08:02 10/10/2023
// Design Name:   BlockCheckr
// Module Name:   D:/file/study/2023Autumn/computer_composition/experiment/P1/P1_L1_BlockChecker/BlockChecker_tb.v
// Project Name:  P1_L1_BlockChecker
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: BlockCheckr
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module BlockChecker_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [7:0] in;

	// Outputs
	wire [3:0] st;
	wire result;

	// Instantiate the Unit Under Test (UUT)
	BlockCheckr uut (
		.clk(clk), 
		.reset(reset), 
		.in(in), 
		.st(st), 
		.result(result)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		in = 0;

		// Wait 100 ns for global reset to finish
		#4;
		reset = 0;
		in = "a";
		#2 in = " ";
		#2 in = "B";
		#2 in = "E";
		#2 in = "g";
		#2 in = "I";
		#2 in = "n";
		#2 in = " ";
		#2 in = "E";
		#2 in = "n";
		#2 in = "d";
		#2 in = "c";
		#2 in = " ";
		#2 in = "e";
		#2 in = "n";
		#2 in = "d";
		#2 in = " ";
		#2 in = "e";
		#2 in = "n";
		#2 in = "d";
		#2 in = " ";
		#2 in = "b";
		#2 in = "E";
		#2 in = "G";
		#2 in = "i";
		#2 in = "n";
		#2 in = " ";
		
		// Add stimulus here

	end
	always #1 clk = ~clk;

endmodule

