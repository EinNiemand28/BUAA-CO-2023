`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:35:40 11/02/2023
// Design Name:   VoterPlus
// Module Name:   D:/file/study/2023Autumn/computer_composition/experiment/P1/practice_after_class/P1_L1_vote_plus/VoterPlus_tb.v
// Project Name:  P1_L1_vote_plus
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: VoterPlus
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module VoterPlus_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [31:0] np;
	reg [7:0] vip;
	reg vvip;

	// Outputs
	wire [7:0] result;

	// Instantiate the Unit Under Test (UUT)
	VoterPlus uut (
		.clk(clk), 
		.reset(reset), 
		.np(np), 
		.vip(vip), 
		.vvip(vvip), 
		.result(result)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		np = 0;
		vip = 0;
		vvip = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

