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
    input wire interrupt,
    output wire [31:0] macroscopic_pc,

    output wire [31:0] i_inst_addr,
    input wire [31:0] i_inst_rdata,

    output wire [31:0] m_data_addr,
    input wire [31:0] m_data_rdata,
    output wire [31:0] m_data_wdata,
    output wire [3:0] m_data_byteen,

    output wire [31:0] m_int_addr,
    output wire [3:0] m_int_byteen,

    output wire [31:0] m_inst_addr,

    output wire w_grf_we,
    output wire [4:0] w_grf_addr,
    output wire [31:0] w_grf_wdata,
    
    output wire [31:0] w_inst_addr
);
    wire [31:0] m_data_wdata_temp, m_data_addr_temp, m_data_rdata_temp;
    wire [3:0] m_data_byteen_temp;

    wire [5:0] HWInt = {3'b0, interrupt, TC1IRQ, TC0IRQ};
    wire [31:0] TC0Addr, TC0Din, TC0Dout;
    wire TC0WE, TC0IRQ;
    wire [31:0] TC1Addr, TC1Din, TC1Dout;
    wire TC1WE, TC1IRQ;
    wire InterruptResponse;

    DataPath u_datapath (
        .clk(clk),
        .reset(reset),
        .HWInt(HWInt),
        
        .i_inst_addr(i_inst_addr),
        .i_inst_rdata(i_inst_rdata),
        
        .m_data_addr(m_data_addr_temp),
        .m_data_rdata(m_data_rdata_temp),
        .m_data_wdata(m_data_wdata_temp),
        .m_data_byteen(m_data_byteen_temp),
        .m_inst_addr(m_inst_addr),

        .w_grf_we(w_grf_we),
        .w_grf_addr(w_grf_addr),
        .w_grf_wdata(w_grf_wdata),
        .w_inst_addr(w_inst_addr),

        .macroscopic_pc(macroscopic_pc)
    );
    assign m_int_addr = (m_data_addr == 32'h0000_7f20 && m_data_byteen == 4'b0001) ? 32'h0000_7f20 : 0;
    assign m_int_byteen = (m_data_addr == 32'h0000_7f20 && m_data_byteen == 4'b0001) ? 4'b0001 : 0;
    // assign m_int_addr = (InterruptResponse && interrupt) ? 32'h0000_7f20 : 0;
    // assign m_int_byteen = (InterruptResponse && interrupt) ? 4'b0001 : 0;
    // assign m_int_byteen = 4'b0001;

    Bridge u_bridge (
        .m_data_addr_temp(m_data_addr_temp),
        .m_data_wdata_temp(m_data_wdata_temp),
        .m_data_byteen_temp(m_data_byteen_temp),
        .m_data_rdata_temp(m_data_rdata_temp),

        .m_data_addr(m_data_addr),
        .m_data_wdata(m_data_wdata),
        .m_data_byteen(m_data_byteen),
        .m_data_rdata(m_data_rdata),

        .TC0Addr(TC0Addr),
        .TC0Din(TC0Din),
        .TC0WE(TC0WE),
        .TC0Dout(TC0Dout),

        .TC1Addr(TC1Addr),
        .TC1Din(TC1Din),
        .TC1WE(TC1WE),
        .TC1Dout(TC1Dout)
    );

    TC u_tc0 (
        .clk(clk),
        .reset(reset),
        .Addr(TC0Addr[31:2]),
        .WE(TC0WE),
        .Din(TC0Din),
        .Dout(TC0Dout),
        .IRQ(TC0IRQ)
    );

    TC u_tc1 (
        .clk(clk),
        .reset(reset),
        .Addr(TC1Addr[31:2]),
        .WE(TC1WE),
        .Din(TC1Din),
        .Dout(TC1Dout),
        .IRQ(TC1IRQ)
    );

endmodule
