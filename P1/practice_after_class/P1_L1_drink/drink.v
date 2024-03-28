`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:23:01 10/15/2023 
// Design Name: 
// Module Name:    drink 
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
module drink(
    input clk,
    input reset,
    input [1:0] coin,
    output reg drink,
    output reg [1:0] back
    );

    reg [1:0] st = 2'b0;
    reg [1:0] money = 2'b0;
    reg flag = 1'b0;
    reg flag2 = 1'b0;

    always @ (*) begin
        if (flag == 1'b1) begin
            drink = 1'b0;
            back = money;
        end
        else if (flag2 == 1'b1) begin
            back = money;
            drink = 1'b1;
        end
        else begin
            drink = 1'b0;
            back = 2'b0;
        end
    end
    always @ (posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            st <= 2'd0;
            flag <= 1'b0;
            flag2 <= 1'b0;
            money <= 2'b0;
        end
        else begin
            case(st)
                2'd0: begin
                    flag <= 1'b0;
                    flag2 <= 1'b0;
                    money <= 2'b0;
                    if (coin == 2'b0) begin
                        st <= st;
                    end
                    else if (coin == 2'b01) begin
                        st <= 2'd1;
                    end
                    else if (coin == 2'b10) begin
                        st <= 2'd2;
                    end
                    else begin
                        money <= 2'b0;
                        flag <= 1'b1;
                        st <= 2'd0;
                    end
                end
                2'd1: begin
                    if (coin == 2'b0) begin
                        st <= st;
                    end
                    else if (coin == 2'b01) begin
                        st <= 2'd2;
                    end
                    else if (coin == 2'b10) begin
                        st <= 2'd3;
                    end
                    else begin
                        money <= 2'b1;
                        flag <= 1'b1;
                        st <= 2'd0;
                    end
                end
                2'd2: begin
                    if (coin == 2'b0) begin
                        st <= st;
                    end
                    else if (coin == 2'b1) begin
                        st <= 2'd3;
                    end
                    else if (coin == 2'b10) begin
                        flag2 <= 1'b1;
                        money <= 2'b0;
                        st <= 2'd0;
                    end
                    else begin
                        flag <= 1'b1;
                        money <= 2'b10;
                        st <= 2'd0;
                    end
                end
                2'd3: begin
                    if (coin == 2'b0) begin
                        st <= st;
                    end
                    else if (coin == 2'b1) begin
                        flag2 <= 1'b1;
                        money <= 2'b0;
                        st <= 2'd0;
                    end
                    else if (coin == 2'b10) begin
                        flag2 <= 1'b1;
                        money <= 2'b1;
                        st <= 2'd0;
                    end
                    else begin
                        flag <= 1'b1;
                        money <= 2'b11;
                        st <= 2'd0;
                    end
                end
            endcase
        end
    end

endmodule
