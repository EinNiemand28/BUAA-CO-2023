`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:36:00 10/10/2023 
// Design Name: 
// Module Name:    gray 
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
module gray(
    input Clk,
    input Reset,
    input En,
    output [2:0] Output,
    output Overflow
    );

    reg [2:0] st; 
    reg flag;
    assign Output = st ^ (st >> 1);
    assign Overflow = flag; 

    always @ (posedge Clk) begin
        if (Reset) begin
            st <= 0;
            flag <= 0;
        end
        else begin
            if (En) begin
                if (st == 3'd7) begin
                    st <= 3'd0;
                    flag <= 1'b1;
                end
                else st <= st + 1;
            end
            else st <= st;
        end
    end

endmodule
