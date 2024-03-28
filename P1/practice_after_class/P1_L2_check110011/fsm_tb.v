`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:06:40 10/15/2023
// Design Name:   fsm
// Module Name:   D:/file/study/2023Autumn/computer_composition/experiment/P1/practice_after_class/P1_L2_check110011/fsm_tb.v
// Project Name:  P1_L2_check110011
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fsm
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fsm_tb;

	// Inputs
	reg clk;
	reg reset;
	reg in;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	fsm uut (
		.clk(clk), 
		.reset(reset), 
		.in(in), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		in = 0;

		// Wait 100 ns for global reset to finish
		#2 reset = 0;
		#2 in = 1;
		#2 in = 1;
		#2 in = 0;
		#2 in = 0;
		#2 in = 1;
		#2 in = 1;
		#2 in = 1;
		#2 in = 0;
		#2 in = 0;
		#2 in = 1;
		#2 in = 1;
        
		// Add stimulus here

	end
    always #1 clk = ~clk;
endmodule

