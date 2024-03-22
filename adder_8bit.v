module adder_8bit#(parameter ADDER_WIDTH = 8)(//-0.079
    input  wire [ADDER_WIDTH-1:0] iA, iB,
    input  wire iC,
    output wire [ADDER_WIDTH-1:0] oSum,
    output wire oC
);
    wire [ADDER_WIDTH-1:0] wP;// = iA | iB;
    wire [ADDER_WIDTH-1:0] wS = iA ^ iB;
    wire [ADDER_WIDTH-1:0] wG;// = iA & iB;
    wire [ADDER_WIDTH:0] wC;
    assign wC[0] = iC;
    
    assign wC[1] = |{wG[0], iC&wP[0]};
    assign wC[2] = |{wG[1], &{wG[0], wP[1]}, &{iC,wP[1:0]}};
    assign wC[3] = |{wG[2], &{wG[1], wP[2]}, &{wG[0], wP[2:1]},  &{iC,wP[2:0]}};
    assign wC[4] = |{wG[3], &{wG[2], wP[3]}, &{wG[1], wP[3:2]},  &{wG[0], wP[3:1]},  &{iC,wP[3:0]}};
    assign wC[5] = |{wG[4], &{wG[3], wP[4]}, &{wG[2], wP[4:3]},  &{wG[1], wP[4:2]},  &{wG[0], wP[4:1]},  &{iC,wP[4:0]}};
    assign wC[6] = |{wG[5], &{wG[4], wP[5]}, &{wG[3], wP[5:4]},  &{wG[2], wP[5:3]},  &{wG[1], wP[5:2]},  &{wG[0], wP[5:1]},  &{iC,wP[5:0]}};
    assign wC[7] = |{wG[6], &{wG[5], wP[6]}, &{wG[4], wP[6:5]},  &{wG[3], wP[6:4]},  &{wG[2], wP[6:3]},  &{wG[1], wP[6:2]},  &{wG[0],wP[6:1]},  &{iC,wP[6:0]}};
    assign wC[8] = |{wG[7], &{wG[6], wP[7]}, &{wG[5], wP[7:6]},  &{wG[4], wP[7:5]},  &{wG[3], wP[7:4]},  &{wG[2], wP[7:3]},  &{wG[1],wP[7:2]},  &{wG[0],wP[7:1]}, &{iC,wP[7:0]}};
    genvar i;
    generate
        for (i=0; i<ADDER_WIDTH; i=i+1) begin
            assign wP[i] = iA[i] | iB[i], wG[i] = iA[i] & iB[i], oSum[i] = ^{wC[i],iA[i],iB[i]};
        end 
    endgenerate
    assign oC = wC[ADDER_WIDTH];
endmodule

//module adder_8bit#(parameter ADDER_WIDTH = 8)(//-0.3
//    input  wire [ADDER_WIDTH-1:0] iA, iB,
//    input  wire iC,
//    output wire [ADDER_WIDTH-1:0] oSum,
//    output wire [ADDER_WIDTH-1:0] G,
//    output wire [ADDER_WIDTH-1:0] P,
//    output wire [ADDER_WIDTH-1:0] oC_array,
//    output wire oC
//);
//    wire [ADDER_WIDTH-1:0] wP = iA | iB;
//    wire [ADDER_WIDTH-1:0] wS = iA ^ iB;
//    wire [ADDER_WIDTH-1:0] wG = iA & iB;
//    wire [ADDER_WIDTH:0] wC;
//    assign wC[0] =  iC;
//    assign wC[1] =  |{wG[0], iC&wP[0]};
//    assign wC[2] =  |{wG[1], &{wG[0], wP[1]}, &{iC,wP[1:0]}};
//    assign wC[3] =  |{wG[2], &{wG[1], wP[2]}, &{wG[0], wP[2:1]},  &{iC,wP[2:0]}};
//    assign wC[4] =  |{wG[3], &{wG[2], wP[3]}, &{wG[1], wP[3:2]},  &{wG[0], wP[3:1]},&{iC,wP[3:0]}};
//    assign wC[5] =  |{wG[4], &{wG[3], wP[4]}, &{wG[2], wP[4:3]},  &{wG[1], wP[4:2]},  &{wG[0], wP[4:1]},  &{iC,wP[4:0]}};
//    assign wC[6] =  |{wG[5], &{wG[4], wP[5]}, &{wG[3], wP[5:4]},  &{wG[2], wP[5:3]},  &{wG[1], wP[5:2]},  &{wG[0], wP[5:1]},  &{iC,wP[5:0]}};
//    assign wC[7] =  |{wG[6], &{wG[5], wP[6]}, &{wG[4], wP[6:5]},  &{wG[3], wP[6:4]},  &{wG[2], wP[6:3]},  &{wG[1], wP[6:2]},  &{wG[0],wP[6:1]},  &{iC,wP[6:0]}};
//    assign wC[8] =  |{wG[7], &{wG[6], wP[7]}, &{wG[5], wP[7:6]},  &{wG[4], wP[7:5]},  &{wG[3], wP[7:4]},  &{wG[2], wP[7:3]},  &{wG[1],wP[7:2]},  &{wG[0],wP[7:1]}, &{iC,wP[7:0]}};
//    genvar i;
//    generate
//        for (i=0; i<ADDER_WIDTH; i=i+1) begin
//            assign oSum[i] = wC[i] ^ wS[i], P[i] = iA[i] | iB[i], wG[i] = iA[i] & iB[i];
//        end 
//    endgenerate
//    assign oC = wC[ADDER_WIDTH];
//    assign G = wG;
//    assign P = wP;
//endmodule