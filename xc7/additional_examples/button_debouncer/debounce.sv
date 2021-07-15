`timescale 1ns / 1ps
`default_nettype none

module debounce(
    input wire logic clk, reset, noisy,
    output logic debounced
    );
    
    logic timerDone, clrTimer;
    
    typedef enum logic[1:0] {s0, s1, s2, s3, ERR='X} stateType;
    stateType ns, cs;
    
    logic[18:0] tA;
    
    timer_par #(500000, 19) T0(clk, clrTimer, 1'b1, timerDone, tA);
    
    always_comb
    begin
    ns = ERR;
    clrTimer = 0;
    debounced = 0;
    
    if (reset)
        ns = s0;
    else
        case (cs)
            s0: begin
                    clrTimer = 1'b1;
                    if (noisy)
                        ns = s1;
                    else
                        ns = s0;
                end    
            s1: if (noisy && timerDone)
                    ns = s2;
                else if (noisy && ~timerDone)
                    ns = s1;
                else
                    ns = s0;
            s2: begin
                    debounced = 1'b1;
                    clrTimer = 1'b1;
                    if (noisy)
                        ns = s2;
                    else
                        ns = s3;
                end
            s3: begin
                    debounced = 1'b1;
                    if (~noisy && timerDone)
                        ns = s0;
                    else if (~noisy && ~timerDone)
                        ns = s3;
                    else
                        ns = s2;                                         
                end                    
        endcase                                                        
    end

    always_ff @(posedge clk)
        cs <= ns;
endmodule
