`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:04:13 10/10/2023 
// Design Name: 
// Module Name:    expr 
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
module expr(
    input clk,
    input clr,
    input [7:0] in,
    output out
    );

    reg [1:0] st;
    wire [1:0] check = (in >= "0" && in <= "9") ? 2'b01 :
                       (in == "+" || in == "*") ? 2'b10 : 2'b00;
    assign out = (st == 2'd1) ? 1'b1 : 1'b0;

    always @ (posedge clk or posedge clr) begin
        if (clr == 1'b1) st <= 0;
        else begin
            case (st)
            2'd0: begin
                if (check == 2'b01) st <= 2'd1;
                else st <= 2'd3;
            end
            2'd1: begin
                if (check == 2'b10) st <= 2'd2;
                else st <= 2'd3;
            end
            2'd2: begin
                if (check == 2'b01) st <= 2'd1;
                else st <= 2'd3;
            end
            2'd3: st <= st;
            default: st <= 0;
            endcase
        end
    end
endmodule
