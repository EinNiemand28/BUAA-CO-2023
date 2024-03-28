`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:37:32 11/11/2023 
// Design Name: 
// Module Name:    mips 
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
module mips (
    input wire clk,
    input wire reset,
    input wire [31:0] i_inst_rdata,
    output wire [31:0] i_inst_addr,
    input wire [31:0] m_data_rdata,
    output wire [31:0] m_data_addr,
    output wire [31:0] m_data_wdata,
    output wire [3:0] m_data_byteen,
    output wire [31:0] m_inst_addr,
    output wire w_grf_we,
    output wire [4:0] w_grf_addr,
    output wire [31:0] w_grf_wdata,
    output wire [31:0] w_inst_addr
);
    DataPath u_datapath (
        .clk(clk),
        .reset(reset),
        .i_inst_rdata(i_inst_rdata),
        .i_inst_addr(i_inst_addr),
        .m_data_rdata(m_data_rdata),
        .m_data_addr(m_data_addr),
        .m_data_wdata(m_data_wdata),
        .m_data_byteen(m_data_byteen),
        .m_inst_addr(m_inst_addr),
        .w_grf_we(w_grf_we),
        .w_grf_addr(w_grf_addr),
        .w_grf_wdata(w_grf_wdata),
        .w_inst_addr(w_inst_addr)
    );

endmodule
