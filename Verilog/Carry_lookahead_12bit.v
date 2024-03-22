module Carry_lookahead_12bit#(parameter ADDER_WIDTH = 12)(
    input  wire [ADDER_WIDTH-1:0] G, P,
    input  wire                   iC,
    output wire                   oC    
);
    wire [ADDER_WIDTH:0]   _C;
    assign _C[12] = &{iC,P};
    assign _C[11] = &{G[0],P[11:1]};
    assign _C[10] = &{G[1],P[11:2]};
    assign _C[9] = &{G[2],P[11:3]};
    assign _C[8] = &{G[3],P[11:4]};
    assign _C[7] = &{G[4],P[11:5]};
    assign _C[6] = &{G[5],P[11:6]};
    assign _C[5] = &{G[6],P[11:7]};
    assign _C[4] = &{G[7],P[11:8]};
    assign _C[3] = &{G[8],P[11:9]};
    assign _C[2] = &{G[9],P[11:10]};
    assign _C[1] = &{G[10],P[11]};
    assign _C[0] = G[ADDER_WIDTH-1];
    
    assign oC = |_C;
endmodule