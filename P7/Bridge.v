`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:31:04 12/10/2023 
// Design Name: 
// Module Name:    Bridge 
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
module Bridge (
    input wire [31:0] m_data_addr_temp,
    input wire [31:0] m_data_wdata_temp,
    input wire [3:0] m_data_byteen_temp,
    output wire [31:0] m_data_rdata_temp,
    
    output wire [31:0] m_data_addr,
    output wire [31:0] m_data_wdata,
    output wire [3:0] m_data_byteen,
    input wire [31:0] m_data_rdata,

    output wire [31:0] TC0Addr,
    output wire [31:0] TC0Din,
    output wire TC0WE,
    input wire [31:0] TC0Dout,

    output wire [31:0] TC1Addr,
    output wire [31:0] TC1Din,
    output wire TC1WE,
    input wire [31:0] TC1Dout
);
    assign m_data_addr = m_data_addr_temp;
    assign m_data_wdata = m_data_wdata_temp;

    assign TC0Addr = m_data_addr_temp;
    assign TC1Addr = m_data_addr_temp;
    assign TC0Din = m_data_wdata_temp;
    assign TC1Din = m_data_wdata_temp;

    wire TC0 = (m_data_addr_temp >= 32'h0000_7f00) && (m_data_addr_temp <= 32'h0000_7f0b);
    wire TC1 = (m_data_addr_temp >= 32'h0000_7f10) && (m_data_addr_temp <= 32'h0000_7f1b);
    wire WE = (| m_data_byteen_temp);

    assign TC0WE = WE && TC0;
    assign TC1WE = WE && TC1;

    assign m_data_byteen = (TC0 || TC1) ? 4'b0000 : m_data_byteen_temp;
    assign m_data_rdata_temp = (TC0) ? TC0Dout :
                               (TC1) ? TC1Dout : m_data_rdata;

endmodule
