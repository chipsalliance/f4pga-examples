module top(
input logic clk, btnc, btnu, btnd, btnl,
input logic[9:0] sw,
output logic[7:0] segment, 
output logic[3:0] anode
);
logic[3:0] dataout1, dataout2; 
logic[7:0] outdata;
register_file_8x4 R0(.clk(clk), .we(btnc), .datain(sw[3:0]), .waddr(sw[6:4]),
.raddr1(sw[6:4]), .raddr2(sw[9:7]), .dataout1(dataout1), .dataout2(dataout2));
assign outdata = (btnu == 1)? dataout2 + dataout1:
(btnd == 1)? dataout2 - dataout1:
{dataout2, dataout1};

SevenSegmentControl S0(.clk(clk), .reset(1'b0), .dataIn(outdata), .digitDisplay(4'b0011), .digitPoint(4'b0000), .anode(anode), .segment(segment[6:0]));
assign segment[7] = 1'b0;
endmodule