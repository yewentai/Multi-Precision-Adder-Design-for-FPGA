module Carry_lookahead_4bit#(parameter ADDER_WIDTH = 4)(
    input  wire [ADDER_WIDTH-1:0] G, P,
    input  wire                   iC,
    output wire                   oC    
);
    wire [ADDER_WIDTH:0]   _C_4 = {iC,P[3],P[2],P[1],P[0]};
    wire [ADDER_WIDTH-1:0] _C_3 = {G[0],P[3],P[2],P[1]};
    wire [ADDER_WIDTH-2:0] _C_2 = {G[1],P[3],P[2]};
    wire [ADDER_WIDTH-3:0] _C_1 = {G[2],P[3]};
    wire [ADDER_WIDTH:0]   _C = { &_C_4, &_C_3, &_C_2, &_C_1, G[3] };
    
    assign oC = |_C;
endmodule

//module Carry_lookahead_4bit#(parameter ADDER_WIDTH = 4)(
//    input  wire [ADDER_WIDTH-1:0] G, P,
//    input  wire                   iC,
//    output wire                   oC    
//);
//    wire [ADDER_WIDTH:0]   _C_4;
//    and(_C_4,iC,P[3],P[2],P[1],P[0]);
//    wire [ADDER_WIDTH-1:0] _C_3;
//    and(_C_3,G[0],P[3],P[2],P[1]);
//    wire [ADDER_WIDTH-2:0] _C_2;
//    and(_C_,G[1],P[3],P[2]);
//    wire [ADDER_WIDTH-3:0] _C_1;
//    and(_C_1,G[2],P[3]);
//    //wire [ADDER_WIDTH:0]   _C = { &_C_4, &_C_3, &_C_2, &_C_1, G[3] };
//    or(oC,_C_1,_C_2,_C_3,_C_4);
//    //assign oC = |_C;
//endmodule