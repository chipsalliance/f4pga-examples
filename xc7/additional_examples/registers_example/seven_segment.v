module seven_segment(
    input [3:0] data,
    output [6:0] segment
    );
    wire [3:0] CA;
    wire [4:0] CB;
    wire [3:0] ND;
    
    not(ND[3], data[3]);
    not(ND[2], data[2]);
    not(ND[1], data[1]);
    not(ND[0], data[0]);

    and(CA[0], ND[3], ND[2], ND[1], data[0]);
    and(CA[1], ND[3], data[2], ND[1], ND[0]);
    and(CA[2], data[3], ND[2], data[1], data[0]);
    and(CA[3], data[3], data[2], ND[1], data[0]);
    
    or(segment[0], CA[0], CA[1], CA[2], CA[3]); 

    and(CB[0], ND[3], data[2], ND[1], data[0]);
    and(CB[1], data[2], data[1], ND[0]);
    and(CB[2], data[3], data[2], ND[0]);
    and(CB[3], data[3], ND[2], data[1], data[0]);
    and(CB[4], data[3], data[2], data[1]);
    
    or(segment[1], CB[0], CB[1], CB[2], CB[3], CB[4]);

    LUT4 #(16'hd004) seg0(.O(segment[2]), .I0(data[0]), .I1(data[1]), .I2(data[2]), .I3(data[3]));
    LUT4 #(16'h8492) seg1(.O(segment[3]), .I0(data[0]), .I1(data[1]), .I2(data[2]), .I3(data[3]));
    LUT4 #(16'h02ba) seg2(.O(segment[4]), .I0(data[0]), .I1(data[1]), .I2(data[2]), .I3(data[3]));
    LUT4 #(16'h208e) seg3(.O(segment[5]), .I0(data[0]), .I1(data[1]), .I2(data[2]), .I3(data[3]));
    LUT4 #(16'h1083) seg4(.O(segment[6]), .I0(data[0]), .I1(data[1]), .I2(data[2]), .I3(data[3]));
    
    
    
endmodule


