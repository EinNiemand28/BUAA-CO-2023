`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:39:48 12/10/2023 
// Design Name: 
// Module Name:    DE 
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
module DE (
    input wire [3:0] MemOp,
    input wire [31:0] Addr,
    input wire [31:0] m_data_rdata,
    input wire ExcDMOv,
    output reg [31:0] ReadData,
    output wire ExcAdEL
);
    wire Error1 = ((MemOp == 4'd1) && (| Addr[1:0])) ||
                  ((MemOp == 4'd2) && Addr[0]);

    wire Error2 = !(((Addr >= 32'h0000_0000) && (Addr <= 32'h0000_2fff)) ||
                    ((Addr >= 32'h0000_7f00) && (Addr <= 32'h0000_7f0b)) ||
                    ((Addr >= 32'h0000_7f10) && (Addr <= 32'h0000_7f1b)) ||
                    ((Addr >= 32'h0000_7f20) && (Addr <= 32'h0000_7f23)));

    wire Error3 = (MemOp != 4'd1) && (Addr >= 32'h0000_7f00) && (Addr <= 32'h0000_7f1b);

    assign ExcAdEL = (MemOp >= 4'd1 && MemOp <= 4'd3) && (ExcDMOv || Error1 || Error2 || Error3);

    always @(*) begin
        case(MemOp)
            4'd1: begin
                ReadData = m_data_rdata;
            end
            4'd2: begin
                if (Addr[1] == 1'b0) begin
                    ReadData = {{16{m_data_rdata[15]}}, m_data_rdata[15:0]};
                end else begin
                    ReadData = {{16{m_data_rdata[31]}}, m_data_rdata[31:16]};
                end
            end
            4'd3: begin
                if (Addr[1:0] == 2'b00) begin
                    ReadData = {{24{m_data_rdata[7]}}, m_data_rdata[7:0]};
                end else if (Addr[1:0] == 2'b01) begin
                    ReadData = {{24{m_data_rdata[15]}}, m_data_rdata[15:8]};
                end else if (Addr[1:0] == 2'b10) begin
                    ReadData = {{24{m_data_rdata[23]}}, m_data_rdata[23:16]};
                end else begin
                    ReadData = {{24{m_data_rdata[31]}}, m_data_rdata[31:24]};
                end
            end
            default: begin
                ReadData = 0;
            end
        endcase
    end

endmodule
