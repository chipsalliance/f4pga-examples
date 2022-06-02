`default_nettype none //enforce explicit declaration of nets

module top (
    input  wire       clk_p,
    input  wire       clk_n,
    output wire [7:0] led
);

  localparam BITS = 8;
  localparam LOG2DELAY = 22;

  wire clk_ibufg;
  IBUFGDS clk_ibufgds_inst(
    .I(clk_p),
    .IB(clk_n),
    .O(clk_ibufg)
  );

  reg [BITS+LOG2DELAY-1:0] counter = 0;

  always @(posedge clk_ibufg) begin
    counter <= counter + 1;
  end

  assign led[7:0] = counter >> LOG2DELAY;
endmodule
