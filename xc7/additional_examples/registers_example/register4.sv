module register4(
input logic clk, we,
input logic[3:0] datain,
output logic[3:0] dataout
);
FDCE my_ff1 (.Q(dataout[0]), .C(clk), .CE(we), .CLR(1'b0), .D(datain[0]));
FDCE my_ff2 (.Q(dataout[1]), .C(clk), .CE(we), .CLR(1'b0), .D(datain[1]));
FDCE my_ff3 (.Q(dataout[2]), .C(clk), .CE(we), .CLR(1'b0), .D(datain[2]));
FDCE my_ff4 (.Q(dataout[3]), .C(clk), .CE(we), .CLR(1'b0), .D(datain[3]));
endmodule