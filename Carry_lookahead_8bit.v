module Carry_lookahead_8bit#(parameter ADDER_WIDTH = 8)(
    input  wire [ADDER_WIDTH-1:0] G, P,
    input  wire                   iC,
    output wire                   oC    
);
    wire _C_8 = &{iC,P};
    wire _C_7 = &{G[0],P[7:1]};
    wire _C_6 = &{G[1],P[7:2]};
    wire _C_5 = &{G[2],P[7:3]};
    wire _C_4 = &{G[3],P[7:4]};
    wire _C_3 = &{G[4],P[7:5]};
    wire _C_2 = &{G[5],P[7:6]};
    wire _C_1 = &{G[6],P[7]};
    
    assign oC = |{ &_C_8, &_C_7, &_C_6, &_C_5, &_C_4, &_C_3, &_C_2, &_C_1, G[ADDER_WIDTH-1] };
endmodule