`timescale 1ns / 1ps
`default_nettype none


module tx(
    input wire logic clk, Reset, Send,
    input wire logic[7:0] Din,
    output logic Sent, Sout
    );
    
    logic timerDone, clrTimer;
    logic bitDone, incBit, clrBit;
    logic startBit, dataBit, parityBit;
    logic[2:0] bitNum;
    logic[12:0] baudCount;
    

    typedef enum logic[2:0] {START, BITS, PAR, STOP, ACK, IDLE, ERR = 'X} StateType;
    StateType ns, cs;

    always_ff @(posedge clk)
    begin
    if (startBit)
        Sout <= 0;
    else if (dataBit)
        Sout <= Din[bitNum];
    else if (parityBit)
        Sout <= ~^Din;
    else
        Sout <= 1;            
    end

    always_ff @(posedge clk)
    begin
        if (clrTimer)
            baudCount <= 0;
        else if (timerDone)
            baudCount <= 0; 
        else
            baudCount <= baudCount + 1'b1; 
    end

    always_comb
    begin
        if (baudCount == 13'd5208)
            timerDone = 1'b1;
        else
            timerDone = 1'b0;        
    end

    always_ff @(posedge clk)
    begin
        if (clrBit)
            bitNum <= 3'b000;
        else if (incBit)
            bitNum <= bitNum + 1'b1;
    end

    always_comb
    begin
        if (bitNum == 3'b111)
            bitDone = 1'b1;
        else
            bitDone = 1'b0;        
    end

    always_comb
    begin
        ns = ERR;
        clrTimer = 0;
        startBit = 0;
        clrBit = 0;
        dataBit = 0;
        incBit = 0;
        parityBit = 0;
        Sent = 0;
        if (Reset)
            ns = IDLE;
        else
            case (cs)
                IDLE: begin
                        clrTimer = 1'b1;
                        if (Send)
                            ns = START;
                        else
                            ns = IDLE;                        
                      end
                START: begin
                        startBit = 1'b1;
                        if (timerDone)
                        begin
                            clrBit = 1'b1;
                            ns = BITS;
                        end
                        else
                            ns = START;
                       end 
                BITS: begin
                        dataBit = 1'b1;
                        if (timerDone && ~bitDone)
                        begin
                            incBit = 1'b1;
                            ns = BITS;
                        end
                        else if (timerDone && bitDone)
                            ns = PAR;
                        else
                            ns = BITS;
                      end
                PAR: begin
                        parityBit = 1'b1;
                        if (timerDone)
                         ns = STOP;
                        else
                         ns = PAR;
                     end
                STOP: if (timerDone)
                        ns = ACK;
                      else
                        ns = STOP;
                ACK: begin
                        Sent = 1'b1;
                        if (~Send)
                            ns = IDLE;
                        else
                            ns = ACK;                        
                     end
            endcase
    end

    always_ff @(posedge clk)
        cs <= ns;
    
endmodule
