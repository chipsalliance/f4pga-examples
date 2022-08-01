/* Spectrum
 *
 * This example consists of a series of triangle wave generator with their phases shifted
 * driving a multichannel PWM generator. The output is supposed to be used to drive LEDs,
 * which will create a spectrum-like effect.
 */

module Counter (
  input  wire clk,
  output wire [(RESOLUTION-1):0] out
);
  parameter RESOLUTION = 4;
  parameter PHASE = 0;
  parameter CEILING = (2**RESOLUTION)-1;

  reg [(RESOLUTION-1):0] counter = PHASE;
    
  always @(posedge clk) begin
    counter <= (counter == CEILING - 1) ? 0 : (counter + 1);
  end

  assign out = counter;
endmodule

module PWMController (
  input  wire clk,
  input  wire [(CHANNELS*RESOLUTION-1):0] fill,
  output wire [(CHANNELS-1):0] out
);
  parameter RESOLUTION = 4;
  parameter CHANNELS = 1;

  reg [(RESOLUTION-1):0] counter = 0;
    
  always @(posedge clk) begin
    counter <= counter + 1;
  end

  genvar i;
  generate
  for (i = 0; i < CHANNELS; i++) begin
    assign out[i] = counter < fill[((i+1)*RESOLUTION-1):(i*RESOLUTION)];
  end
  endgenerate
endmodule

module TriGen (
  input  wire clk,
  input  wire [(RESOLUTION):0] ceiling,
  output wire [(RESOLUTION-1):0] out
);
  parameter RESOLUTION = 4;
  parameter PHASE = 0;
  parameter CEILING = 2**RESOLUTION;

  wire [RESOLUTION:0] counter_out;

  Counter #(
    .RESOLUTION  (RESOLUTION+1),
    .PHASE       (PHASE)
  ) counter (
    .clk  (clk),
    .out  (counter_out)
  );

  wire [RESOLUTION:0] out_wide;

  assign out_wide = counter_out >= CEILING
    ? ((~counter_out)+1)
    : counter_out;
  
  assign out = out_wide[RESOLUTION:1];
endmodule

module top (
  input clk,
  output [(BITS-1):0] led
);

  localparam BITS = 3;
  localparam LOG2DELAY = 18;

  wire [(BITS-1):0] ledctl;
  wire [(BITS*8-1):0] ledfills;

  genvar i;
  generate
    for (i = 0; i < BITS; i++) begin

      wire [8+LOG2DELAY-1:0] trigen_out;

      TriGen #(
        .RESOLUTION  (8+LOG2DELAY),
        .PHASE       (i*((2**8)/BITS)*(2**LOG2DELAY))
      ) trigen (
        .clk  (clk),
        .out  (trigen_out)
      );

      assign ledfills[((i+1)*8-1):(i*8)] = trigen_out >> LOG2DELAY;
    end
  endgenerate
  
  PWMController #(
    .RESOLUTION  (8),
    .CHANNELS    (BITS)
  ) pwm (
    .clk   (clk),
    .fill  (ledfills),
    .out   (ledctl)
  );
  
  assign led = ~ledctl;
endmodule
