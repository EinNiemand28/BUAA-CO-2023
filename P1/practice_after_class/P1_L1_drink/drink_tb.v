`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:11:21 10/15/2023
// Design Name:   drink
// Module Name:   D:/file/study/2023Autumn/computer_composition/experiment/P1/practice_after_class/P1_L1_drink/drink_tb.v
// Project Name:  P1_L1_drink
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: drink
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module drink_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [1:0] coin;

	// Outputs
	wire drink;
	wire [1:0] back;

	// Instantiate the Unit Under Test (UUT)
	drink uut (
		.clk(clk), 
		.reset(reset), 
		.coin(coin), 
		.drink(drink), 
		.back(back)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		coin = 0;
		#10 reset = 0;
		// Wait 100 ns for global reset to finish
		#10 coin = 2'b0;
		#10 coin = 2'b0;
		#10 coin = 2'b0;
		#10 coin = 2'b0;
		#10 coin = 2'b0;
		#10 coin = 2'b1;
		#10 coin = 2'b1;
		#10 coin = 2'b1;
		#10 coin = 2'b1;
		#10 coin = 2'b1;
		#10 coin = 2'b1;
		#10 coin = 2'b0;
		#10 coin = 2'b10;
		#10 coin = 2'b1;
		#10 coin = 2'b10;
		#10 coin = 2'b1;
		#10 coin = 2'b1;
		#10 coin = 2'b10;
		#10 coin = 2'b10;
		#10 coin = 2'b10;
		#10 coin = 2'b10;
		#10 coin = 2'b1;
		#10 coin = 2'b1;
		#10 coin = 2'b1;
		#10 coin = 2'b11;
        
		// Add stimulus here

	end
    always #5 clk = ~clk;
endmodule

