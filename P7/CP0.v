`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:30:21 12/10/2023 
// Design Name: 
// Module Name:    CP0 
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
`default_nettype none
module CP0 (
    input wire clk,
    input wire reset,
    input wire WE,
    input wire [4:0] CP0Add,
    input wire [31:0] CP0In,
    output wire [31:0] CP0Out,
    input wire [31:0] VPC,
    input wire BDIn,
    input wire [4:0] ExcCodeIn,
    input wire [5:0] HWInt,
    input wire EXLClr,
    output wire [31:0] EPCOut,
    output wire Req
);
    reg [31:0] SR, Cause, EPC;

    wire ExcReq = !SR[1] && (|ExcCodeIn);
    wire IntReq = !SR[1] && SR[0] && (|(HWInt & SR[15:10]));
    assign Req = ExcReq | IntReq;

    wire [31:0] EPC_temp = (Req) ? (BDIn ? VPC - 4 : VPC) : EPC;

    always @(posedge clk) begin
        if (reset) begin
            SR <= 0;
            Cause <= 0;
            EPC <= 0;
        end else begin
            if (EXLClr) begin
                SR[1] <= 1'b0;
            end
            if (Req) begin
                Cause[31] <= BDIn;
                Cause[6:2] <= IntReq ? 5'd0 : ExcCodeIn;
                SR[1] <= 1'b1;
                EPC <= EPC_temp;
            end else if (WE) begin
                if (CP0Add == 12) begin
                    SR <= CP0In;
                end else if (CP0Add == 14) begin
                    EPC <= CP0In;
                end
            end
            Cause[15:10] <= HWInt;
        end
    end

    assign EPCOut = EPC_temp;
    assign CP0Out = (CP0Add == 12) ? SR :
                    (CP0Add == 13) ? Cause :
                    (CP0Add == 14) ? EPC : 0;

endmodule
