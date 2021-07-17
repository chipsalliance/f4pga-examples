module register_file_8x4(
input logic clk, we,
input logic[3:0] datain,
input logic[2:0] waddr, raddr1, raddr2,
output logic[3:0] dataout1, dataout2
);
logic[7:0] RWS;
logic[3:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7;
assign RWS = {8{we}} & (8'b00000001 << waddr);
register4 R1 (.clk(clk), .we(RWS[0]), .datain(datain), .dataout(reg0));
register4 R2 (.clk(clk), .we(RWS[1]), .datain(datain), .dataout(reg1));
register4 R3 (.clk(clk), .we(RWS[2]), .datain(datain), .dataout(reg2));
register4 R4 (.clk(clk), .we(RWS[3]), .datain(datain), .dataout(reg3));
register4 R5 (.clk(clk), .we(RWS[4]), .datain(datain), .dataout(reg4));
register4 R6 (.clk(clk), .we(RWS[5]), .datain(datain), .dataout(reg5));
register4 R7 (.clk(clk), .we(RWS[6]), .datain(datain), .dataout(reg6));
register4 R8 (.clk(clk), .we(RWS[7]), .datain(datain), .dataout(reg7));
assign dataout1 = (raddr1 == 0)?reg0:
(raddr1 == 1)?reg1:
(raddr1 == 2)?reg2:
(raddr1 == 3)?reg3:(raddr1 == 4)?reg4:
(raddr1 == 5)?reg5:
(raddr1 == 6)?reg6:
reg7;
assign dataout2= (raddr2 == 0)?reg0:
(raddr2 == 1)?reg1:
(raddr2 == 2)?reg2:
(raddr2 == 3)?reg3:
(raddr2 == 4)?reg4:
(raddr2 == 5)?reg5:
(raddr2 == 6)?reg6:
reg7;
endmodule