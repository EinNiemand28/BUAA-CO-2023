`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:00:56 10/10/2023 
// Design Name: 
// Module Name:    BlockCheckr 
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
module BlockChecker(
    input clk,
    input reset,
    input [7:0] in,
    // output reg [3:0] st, 
    output result
    );

    wire letter = (in == " ") ? 1'b0 : 1'b1;
    reg [31:0] cnt;
    reg [3:0] st;

    assign result = (cnt == 32'b0 && st != 4'd6 && st != 4'd10) ? 1'b1 :
                    (cnt == 32'b1 && st == 4'd10) ? 1'b1 : 1'b0;

    always @ (st, cnt, reset) begin
        if (reset == 1'b1) cnt = 32'b0;
        else begin
            if (cnt != 32'hffff) begin
                if (st == 4'd7) begin
                    cnt = cnt + 32'b1;
                end
                else if (st == 4'd11) begin
                    if (cnt == 32'b0) cnt = 32'hffff;
                    else cnt = cnt - 32'b1;
                end
                else cnt = cnt;
            end
            else cnt = cnt;
        end
    end

    always @ (posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            st <= 4'd0; 
        end
        else begin
            case (st)
                4'd0: begin
                    if (letter == 1'b1) begin
                        if (in == "b" || in == "B") st <= 4'd2;
                        else if (in == "e" || in == "E") st<= 4'd8;
                        else st <= 4'd1;
                    end
                    else st <= 4'd0;
                end
                4'd1: begin//其他单词
                    if (letter == 1'b1) st <= 4'd1;
                    else st <= 4'd0;
                end
                4'd2: begin
                    if (in == "e" || in == "E") st <= 4'd3;
                    else if (letter == 1'b1) st <= 4'd1;
                    else st <= 4'd0;
                end
                4'd3: begin
                    if (in == "g" || in == "G") st <= 4'd4;
                    else if (letter == 1'b1) st <= 4'd1;
                    else st <= 4'd0;
                end
                4'd4: begin
                    if (in == "i" || in == "I") st <= 4'd5;
                    else if (letter == 1'b1) st <= 4'd1;
                    else st <= 4'd0;
                end
                4'd5: begin
                    if (in == "n" || in == "N") st <= 4'd6;
                    else if (letter == 1'b1) st <= 4'd1;
                    else st <= 4'd0;
                end
                4'd6: begin//出现begin字串
                    if (letter == 1'b1) st <= 4'd1;
                    else st <= 4'd7;
                end
                4'd7: begin//出现begin单词
                    if (in == "b" || in == "B") st <= 4'd2;
                    else if (in == "e" || in == "E") st <= 4'd8;
                    else if (letter == 1'b1) st <= 4'd1;
                    else st <= 4'd0;
                end
                'd8: begin
                    if (in == "n" || in == "N") st <= 4'd9;
                    else if (letter == 1'b1) st <= 4'd1;
                    else st <= 4'd0;
                end
                'd9: begin
                    if (in == "d" || in == "D") st <= 4'd10;
                    else if (letter == 1'b1) st <= 4'd1;
                    else st <= 4'd0;
                end
                'd10: begin//出现end字串
                    if (letter == 1'b1) st <= 4'd1;
                    else st <= 4'd11;
                end
                'd11: begin//出现end单词
                    if (in == "b" || in == "B") st <= 4'd2;
                    else if (in == "e" || in == "E") st <= 4'd8;
                    else if (letter == 1'b1) st <= 4'd1;
                    else st <= 4'd0;
                end
                default: st <= 4'd0;
            endcase
        end
    end

endmodule
