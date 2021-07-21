`timescale 1ns / 1ps
`default_nettype none

module top(
    input wire logic clk, btnc, sw,
    output logic[3:0] anode,
    output logic[7:0] segment
    );
    
    logic[15:0] digitData;
    
    stopwatch SW0(clk, btnc, sw, digitData[3:0], digitData[7:4], digitData[11:8], digitData[15:12]);
    SevenSegmentControl SSC0(clk, btnc, digitData, 4'b1111 , 4'b0100 , anode, segment);
endmodule
