`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:03:03 10/15/2023 
// Design Name: 
// Module Name:    fsm 
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
module fsm(
    input clk,
    input reset,
    input in,
    output out
    );

    reg [5:0] st = 6'b0;
    assign out = (st == 6'b110011) ? 1'b1 : 1'b0;

    always @ (posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            st <= 6'b0;
        end
        else begin
            st <= ((st << 1'b1) | in);
        end
    end

endmodule
