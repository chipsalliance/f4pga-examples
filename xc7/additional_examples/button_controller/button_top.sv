`timescale 1ns / 1ps
`default_nettype none

module top(
    input wire logic clk, btnu, btnc,
    output logic[3:0] anode,
    output logic[7:0] segment
    );
    
    
    logic sync;
    logic syncToDebounce;
    logic debounceToOneShot;
    logic f1, f2;
    logic f3, f4;
    logic oneShotToCounter;
    logic[7:0] counterToSevenSegment;
    logic[7:0] counterToSevenSegment2;
    logic oneShotToCounter2;
    logic s0, s1;   
    debounce d0(clk, btnu, syncToDebounce, debounceToOneShot);
    
    assign oneShotToCounter = f1 && ~f2;

    assign oneShotToCounter2 = f3 && ~f4;
    

    timer_par #(256, 8) T0(clk, btnu, oneShotToCounter, s0, counterToSevenSegment);

    timer_par #(256, 8) T1(clk, btnu, oneShotToCounter2, s1, counterToSevenSegment2);
    
    
    SevenSegmentControl SSC0 (clk, btnu, {counterToSevenSegment2, counterToSevenSegment}, 4'b1111, 4'b0000, anode, segment);
    
    always_ff @(posedge clk)
    begin

        sync <= btnc;
        syncToDebounce <= sync;  
        
        f1 <= debounceToOneShot;
        f2 <= f1;
        
        f3 <= syncToDebounce;
        f4 <= f3;
    end
endmodule
