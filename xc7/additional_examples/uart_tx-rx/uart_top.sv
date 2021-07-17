module top(
input wire logic clk, btnc, rx_in,
input wire logic[7:0] sw,
output logic[7:0] segment, 
output logic[3:0] anode,
output logic tx_debug, tx_out,
output logic[4:0] debugLED
);
logic rx_error, rx_debug;

logic busyByBy, tx_mid, send, btn[1:0];
tx T0(.tx_out(tx_mid), .odd(1'b0), .busy(busyByBy), .din(sw), .clk(clk), .send(btn[1]),
.state(debugLED));
assign tx_out = tx_mid;
assign tx_debug = tx_mid;

logic busyByByRx, dataGoner, btnRx[1:0];
logic[7:0] rx_data;
rx R0(.rx_in(rx_in), .odd(1'b0), .busy(busyByByRx), .data_strobe(dataGoner),
.dout(rx_data), .error(rx_error), .clk(clk));
assign rx_debug = rx_in;

SevenSegmentControl S1(.dataIn({rx_data[7:0],
sw[7:0]}), .reset(0), .digitDisplay(4'hf), .digitPoint(4'h4), .anode(anode),
.segment(segment), .clk(clk));
always_ff @(posedge clk)
btn[0] <= btnc;
always_ff @(posedge clk)
btn[1] <= btn[0];

endmodule
