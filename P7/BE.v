`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:48:34 11/24/2023 
// Design Name: 
// Module Name:    BE 
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
module BE (
    input wire Req,
    input wire [3:0] MemOp,
    input wire [31:0] Addr,
    input wire ExcDMOv,
    input wire [31:0] WriteData,
    output reg [3:0] m_data_byteen,
    output reg [31:0] m_data_wdata,
    output wire ExcAdES
);
    wire Error1 = ((MemOp == 4'd4) && (| Addr[1:0])) ||
                  ((MemOp == 4'd5) && Addr[0]);

    wire Error2 = !(((Addr >= 32'h0000_0000) && (Addr <= 32'h0000_2fff)) ||
                    ((Addr >= 32'h0000_7f00) && (Addr <= 32'h0000_7f0b)) || 
                    ((Addr >= 32'h0000_7f10) && (Addr <= 32'h0000_7f1b)) ||
                    ((Addr >= 32'h0000_7f20) && (Addr <= 32'h0000_7f23)));
    
    wire Error3 = ((Addr >= 32'h0000_7f08) && (Addr <= 32'h0000_7f0b)) ||
                  ((Addr >= 32'h0000_7f18) && (Addr <= 32'h0000_7f1b)) ||
                  ((MemOp != 4'd4) && (Addr >= 32'h0000_7f00) && (Addr <= 32'h0000_7f1b));
    
    assign ExcAdES = (MemOp >= 4'd4 && MemOp <= 4'd6) && (ExcDMOv || Error1 || Error2 || Error3);

    always @(*) begin
        if (!Req) begin
            case(MemOp)
                4'd4: begin
                    m_data_byteen = 4'b1111;
                    m_data_wdata = WriteData;
                end
                4'd5: begin
                    if (Addr[1] == 1'b0) begin
                        m_data_byteen = 4'b0011;
                        m_data_wdata = {16'b0, WriteData[15:0]};
                    end else begin
                        m_data_byteen = 4'b1100;
                        m_data_wdata = {WriteData[15:0], 16'b0};
                    end
                end
                4'd6: begin
                    if (Addr[1:0] == 2'b00) begin
                        m_data_byteen = 4'b0001;
                        m_data_wdata = {24'b0, WriteData[7:0]};
                    end else if (Addr[1:0] == 2'b01) begin
                        m_data_byteen = 4'b0010;
                        m_data_wdata = {16'b0, WriteData[7:0], 8'b0};
                    end else if (Addr[1:0] == 2'b10) begin
                        m_data_byteen = 4'b0100;
                        m_data_wdata = {8'b0, WriteData[7:0], 16'b0};
                    end else begin
                        m_data_byteen = 4'b1000;
                        m_data_wdata = {WriteData[7:0], 24'b0};
                    end
                end
                default: begin
                    m_data_byteen = 4'b0000;
                    m_data_wdata = 32'b0;
                end
            endcase
        end else begin
            m_data_byteen = 4'b0000;
            m_data_wdata = 32'b0;
        end
    end

endmodule
