
module rx #(parameter CLK_FREQUENCY = 100000000, BAUD_RATE =
19200)(
input wire logic clk, odd, rx_in,
output logic[7:0] dout,
output logic data_strobe, error, busy
);
logic ResetTimer, EnableTimer, LastCycle, HalfCycle, LastBit, NextBit = 0,
ResetCounter,
Shift, Stop, Parity;
localparam ONE_BIT_CNT = CLK_FREQUENCY / BAUD_RATE;
localparam HALF_CNT = ONE_BIT_CNT / 2;
function integer clogb2;
input [31:0] value;
begin
value = value - 1;
for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1) begin
value = value >> 1;
end
end
endfunction

localparam NUM_BITS_FULL_CNT = clogb2(ONE_BIT_CNT);
logic[NUM_BITS_FULL_CNT - 1:0] count = 0;

always_ff@ (posedge clk)
begin
if(ResetTimer || count == ONE_BIT_CNT)
count <= 0;
else if(EnableTimer)
count <= count + 1;
end
assign LastCycle = (count == ONE_BIT_CNT) ? 1'b1:1'b0;

assign HalfCycle = (count == HALF_CNT) ? 1'b1:1'b0;

assign error = ~(((^dout)^odd)==Parity)||(~Stop);
logic[3:0] countBit = 0;
always_ff @(posedge clk)
begin
if(NextBit)
countBit <= countBit + 1;
else if(ResetCounter || LastBit) 
countBit <= 0;
end
assign LastBit = (countBit == 4'b1011) ? 1'b1:1'b0;

logic[9:0] shift = 10'b1111111111;
always_ff @(posedge clk)
begin
if(Shift)
shift <= {rx_in, shift[9:1]};
end
assign Stop = shift[9];assign Parity = shift[8];
assign dout = shift[7:0];

typedef enum {IDLE, HALF, FULL, LOAD} stateType;
stateType ns, cs;
always_comb
begin
ns = cs;
Shift = 0;
busy = 1;
EnableTimer = 0;
ResetTimer = 0;
ResetCounter = 0;
data_strobe = 0;
NextBit = 0;
case(cs)
IDLE:
begin
ResetTimer = 1;ResetCounter = 1;
busy = 0;
if(!rx_in)
ns = HALF;
end
HALF:
begin
EnableTimer = 1;
if(!HalfCycle && rx_in)
ns = IDLE;
else if(HalfCycle)
ns = LOAD;
end
LOAD:
begin
busy = 1;
Shift = 1;
NextBit = 1;ResetTimer = 1;
ns = FULL;
end
FULL:
begin
busy = 1;
EnableTimer = 1;
if(LastCycle)
ns = LOAD;
else if(LastBit)
begin
data_strobe = 1;
ns = IDLE;
end
end
endcase
end
always_ff @(posedge clk)
cs <= ns;endmodule