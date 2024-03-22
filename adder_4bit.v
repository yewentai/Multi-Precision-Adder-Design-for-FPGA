///////////////////WNS == 1.617WHS == 0.244/////////////////
module adder_4bit#(parameter ADDER_WIDTH = 4)(
    input  wire [ADDER_WIDTH-1:0] iA, iB,
    input  wire iC,
    output wire [ADDER_WIDTH-1:0] oSum,
    output wire oC
);
    wire [ADDER_WIDTH-1:0] wP = iA ^ iB;
    wire [ADDER_WIDTH-1:0] wG = iA & iB;
    wire [ADDER_WIDTH:0] wC;
    assign wC[0] = iC;
    assign wC[1] = |{wG[0],iC&wP[0]};
    assign wC[2] = |{wG[1],&{wG[0],wP[1]},&{iC,wP[1:0]}};
    assign wC[3] = |{wG[2],&{wG[1],wP[2]},&{wG[0],wP[2:1]},&{iC,wP[2:0]}};
    assign wC[4] = |{wG[3],&{wG[2],wP[3]},&{wG[1],wP[3:2]},&{wG[0],wP[3:1]},&{iC,wP}};
    assign oSum = wP ^ wC[ADDER_WIDTH-1:0];
    assign oC = wC[ADDER_WIDTH];
endmodule