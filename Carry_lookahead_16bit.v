module Carry_lookahead_16bit#(parameter ADDER_WIDTH = 16)(
    input  wire [ADDER_WIDTH-1:0] G, P,
    input  wire                   iC,
    output wire                   oC    
);
    wire [ADDER_WIDTH:0]    _C_16 = {iC,P};
    wire [ADDER_WIDTH-1:0]  _C_15 = {G[0],P[15:1]};
    wire [ADDER_WIDTH-2:0]  _C_14 = {G[1],P[15:2]};
    wire [ADDER_WIDTH-3:0]  _C_13 = {G[2],P[15:3]};
    wire [ADDER_WIDTH-4:0]  _C_12 = {G[3],P[15:4]};
    wire [ADDER_WIDTH-5:0]  _C_11 = {G[4],P[15:5]};
    wire [ADDER_WIDTH-6:0]  _C_10 = {G[5],P[15:6]};
    wire [ADDER_WIDTH-7:0]  _C_9  = {G[6],P[15:7]};
    wire [ADDER_WIDTH-8:0]  _C_8  = {G[7],P[15:8]};
    wire [ADDER_WIDTH-9:0]  _C_7  = {G[8],P[15:9]};
    wire [ADDER_WIDTH-10:0] _C_6  = {G[9],P[15:10]};
    wire [ADDER_WIDTH-11:0] _C_5  = {G[10],P[15:11]};
    wire [ADDER_WIDTH-12:0] _C_4  = {G[11],P[15:12]};
    wire [ADDER_WIDTH-13:0] _C_3  = {G[12],P[15:13]};
    wire [ADDER_WIDTH-14:0] _C_2  = {G[13],P[15:14]};
    wire [ADDER_WIDTH-15:0] _C_1  = {G[14],P[15]};
    wire [ADDER_WIDTH:0]   _C    = { &_C_16,&_C_15, &_C_14, &_C_13, &_C_12, &_C_11,&_C_10, &_C_9, &_C_8, &_C_7, &_C_6, &_C_5, &_C_4, &_C_3, &_C_2, &_C_1, G[15] };
    
    assign oC = |_C;
endmodule