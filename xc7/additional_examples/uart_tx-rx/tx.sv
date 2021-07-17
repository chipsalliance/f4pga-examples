module tx #(parameter CLK_FREQUENCY = 100000000, BAUD_RATE = 19200)(
input wire logic clk, send, odd,
input wire logic[7:0] din,
output logic busy, tx_out,
output logic[4:0] state
);
logic EnableTimer, ResetTimer, LastCycle, LastBit, NextBit, ResetCounter,
Shift, Load, ParityBit;
localparam MAX_COUNT = CLK_FREQUENCY / BAUD_RATE;
function integer clogb2;
input [31:0] value;
begin
value = value - 1;
for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1) begin
value = value >> 1;
end
end
endfunction
localparam NUM_BITS = clogb2(MAX_COUNT);
logic[NUM_BITS - 1:0] count = 0;

always_ff@ (posedge clk)
begin
if(ResetTimer || count == MAX_COUNT)
count <= 0;
else if(EnableTimer)
count <= count + 1;
end
assign LastCycle = (count == MAX_COUNT) ? 1'b1:1'b0;

assign ParityBit = ((^din)^odd);

logic[3:0] countBit = 0;
always_ff @(posedge clk)
begin
if(NextBit)
countBit <= countBit + 1;
else if(ResetCounter == 1'b1 || countBit == 4'd10)
countBit <= 0;
end
assign LastBit = (countBit == 4'b1001) ? 1'b1:1'b0;

logic[9:0] shift = 10'b1111111111;
always_ff @(posedge clk)
begin
if(Load)
shift <= {ParityBit, din, 1'b0};
else if(Shift)
shift <= {1'b1, shift[9:1]};
end
assign tx_out = shift[0];

localparam Id = 5'b00001;
localparam Lo = 5'b00010;
localparam Co = 5'b00100;
localparam Sh = 5'b01000;
localparam Wa = 5'b10000;

logic [4:0] ns, cs=Id;
assign state = cs;
always_comb
begin
ns = cs;
Load = 0;
busy = 0;
ResetCounter = 0;
ResetTimer = 0;
Shift = 0;
ResetTimer = 0;
NextBit = 0;
EnableTimer =0;
case(cs)
Id:
if(send)
ns = Lo;
Lo:
begin
Load = 1;
busy = 1;
ResetCounter = 1;
ResetTimer = 1;
ns = Co;
end
Co:
begin
busy = 1;
EnableTimer = 1;
if(LastCycle)
ns = Sh;
end
Sh:begin
Shift = 1;
ResetTimer = 1;
NextBit = 1;
busy = 1;
if(~LastBit)
ns = Co;
else
ns = Wa;
end
Wa:
if(~send)
ns = Id;
endcase
end
always_ff @(posedge clk)
cs <= ns;
endmodule