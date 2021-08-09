// Project F Library - 640x480p60 Clock Generation (XC7)
// (C)2021 Will Green, open source hardware released under the MIT License
// Learn more at https://projectf.io

// Changes made by Joshua Fife: 
// Replaced MMCME2_BASE primitive with PLLE2_ADV since symbiflow does not currently support MMCME2

// Changed MULT_MASTER from 31.5 to 9 DIV_MASTER from 5 to 1 and DIV_PIX from 25 to 36. 
// this change was made to get a pixel clock of 25MHz that would work with the PLL.

`default_nettype none
`timescale 1ns / 1ps

module clock_gen_480p #(
    parameter MULT_MASTER=9,   // master clock multiplier (2.000-64.000)
    parameter DIV_MASTER=1,       // master clock divider (1-106)
    parameter DIV_PIX=36,         // pixel clock divider (1-128)
    parameter IN_PERIOD=10.0      // period of master clock in ns
    ) (
    input  wire logic clk,        // board oscillator
    input  wire logic rst,        // reset
    output      logic clk_pix,    // pixel clock
    output      logic clk_locked  // generated clocks locked?
    );

    logic clk_fb;         // internal clock feedback
    logic clk_pix_unbuf;  // unbuffered pixel clock
    logic locked;         // unsynced lock signal

    
    PLLE2_ADV #(
        .CLKFBOUT_MULT(MULT_MASTER),
        .CLKIN1_PERIOD(IN_PERIOD),
        .CLKOUT0_DIVIDE(DIV_PIX),
        .CLKOUT1_DIVIDE(1),  // included for Veriltator (TMDS clock)
        .DIVCLK_DIVIDE(DIV_MASTER)
    ) PLLE2_ADV_inst (
        .CLKIN1(clk),
        .RST(rst),
        .CLKOUT0(clk_pix_unbuf),
        .LOCKED(locked),
        .CLKFBOUT(clk_fb),
        .CLKFBIN(clk_fb),
        /* verilator lint_off PINCONNECTEMPTY */
        .CLKOUT1(),
        .CLKOUT2(),
        .CLKOUT3(),
        .CLKOUT4(),
        .CLKOUT5()
        /* verilator lint_on PINCONNECTEMPTY */
    );

    // explicitly buffer output clock
    BUFG bufg_clk(.I(clk_pix_unbuf), .O(clk_pix));

    // ensure clock lock is synced with pixel clock
    logic locked_sync_0;
    always_ff @(posedge clk_pix) begin
        locked_sync_0 <= locked;
        clk_locked <= locked_sync_0;
    end
endmodule


