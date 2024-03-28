`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:13:47 10/15/2023 
// Design Name: 
// Module Name:    string2 
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
module string2(
    input clk, 
    input clr,
    input [7:0] in,
    output out
    );

    reg [2:0] st;
    assign out = (st == 3'd2) ? 1'b1 : 1'b0;
    always @ (posedge clk or posedge clr) begin
        if (clr == 1'b1) begin
            st <= 3'd0;
        end
        else begin
            case(st)
                3'd0: begin //空串
                    if (in >= "0" && in <="9") begin
                        st <= 3'd2;
                    end
                    else if (in == "(") begin
                        st <= 3'd4;
                    end
                    else begin
                        st <= 3'd1;
                    end
                end
                3'd1: begin //不合法
                    st <= st;
                end
                3'd2: begin //合法
                    if (in == "+" || in == "*") begin
                        st <= 3'd3;
                    end
                    else begin
                        st <= 3'd1;
                    end
                end
                3'd3: begin// F+ or F*
                    if (in >= "0" && in <= "9") begin
                        st <= 3'd2;
                    end
                    else if (in == "(") begin
                        st <= 3'd4;
                    end
                    else begin
                        st <= 3'd1;
                    end
                end
                //以下为括号处理
                3'd4: begin // 括号内空
                    if (in >= "0" && in <= "9") begin
                        st <= 3'd5;
                    end
                    else begin
                        st <= 3'd1;
                    end
                end
                3'd5: begin //括号内为F
                    if (in == ")") begin
                        st <= 3'd2;
                    end
                    else if (in == "+" || in == "*") begin
                        st <= 3'd6;
                    end
                    else begin
                        st <= 3'd1;
                    end
                end
                3'd6: begin //括号内为F+ or F*
                    if (in >= "0" && in <= "9") begin
                        st <= 3'd5;
                    end
                    else begin
                        st <= 3'd1;
                    end
                end
                default: st <= 3'd1;
                //default改成3'd0就一个点都过不了了，不知道为什么
            endcase
        end
    end
endmodule
