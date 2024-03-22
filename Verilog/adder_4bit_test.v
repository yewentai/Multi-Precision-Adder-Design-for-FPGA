///////////////////////////////////////////5.627 0.144/////////////////////////////
module adder_4bit_test#(parameter ADDER_WIDTH = 4)(
    input  wire [ADDER_WIDTH-1:0] iA, iB,
    input  wire iC,
    output wire [ADDER_WIDTH-1:0] oSum,
    output wire [ADDER_WIDTH-1:0] G,
    output wire [ADDER_WIDTH-1:0] P,
    output wire [ADDER_WIDTH-1:0] oC_array,
    output wire oC
);
    wire [ADDER_WIDTH-1:0] wP = iA ^ iB;
    wire [ADDER_WIDTH-1:0] wG = iA & iB;
    wire [ADDER_WIDTH:0] wC;
    assign wC[0] = iC;
    //assign wC[1] = |{iA[0]&iB[0],iA[0]&iC,iC&iB[0]};
    assign wC[1] = |{wG[0],{iC&wP[0]}};
    //assign wC[2] = |{&{iA[1],iB[1]},&{iA[1],iA[0],iB[0]},&{iA[1],iA[0],iC},&{iA[1],iC,iB[0]},&{iB[1],iA[0],iB[0]},&{iB[1],iA[0],iC},&{iB[1],iC,iB[0]}};
    assign wC[2] = |{wG[1],&{wG[0],wP[1]},&{iC,wP[1:0]}};
    assign wC[3] = |{wG[2],&{wG[1],wP[2]},&{wG[0],wP[2:1]},&{iC,wP[2:0]}};
    assign wC[4] = |{wG[3],&{wG[2],wP[3]},&{wG[1],wP[3:2]},&{wG[0],wP[3:1]},&{iC,wP}};
    assign oC_array = wC[ADDER_WIDTH:1];
    assign oSum = wC[ADDER_WIDTH-1:0] ^ wP;
    assign oC = wC[ADDER_WIDTH];
    assign G = wG;
    assign P = wP;
endmodule
/////////////////////////5.043 0.144///////////////////////
//module adder_4bit_test#(parameter ADDER_WIDTH = 4)(
//    input  wire [ADDER_WIDTH-1:0] iA, iB,
//    input  wire iC,
//    output wire [ADDER_WIDTH-1:0] oSum,
//    output wire [ADDER_WIDTH-1:0] G,
//    output wire [ADDER_WIDTH-1:0] P,
//    output wire [ADDER_WIDTH-1:0] oC_array,
//    output wire oC
//);
//    wire [ADDER_WIDTH-1:0] wP = iA ^ iB;
//    wire [ADDER_WIDTH-1:0] wG = iA & iB;
//    wire [ADDER_WIDTH:0] wC;
//    assign wC[0] = iC;
//    //assign wC[1] = |{iA[0]&iB[0],iA[0]&iC,iC&iB[0]};
//    assign wC[1] = wG[0] | (iC&wP[0]);
//    //assign wC[2] = |{&{iA[1],iB[1]},&{iA[1],iA[0],iB[0]},&{iA[1],iA[0],iC},&{iA[1],iC,iB[0]},&{iB[1],iA[0],iB[0]},&{iB[1],iA[0],iC},&{iB[1],iC,iB[0]}};
//    assign wC[2] = wG[1] | (wG[0]&wP[1]) | (iC&wP[1]&wP[0]);
//    assign wC[3] = wG[2] | (wG[1]&wP[2]) | (wG[0]&wP[2]&wP[1]) | (iC&wP[2]&wP[0]);
//    assign wC[4] = wG[3] | (wG[2]&wP[3]) | (wG[1]&wP[3]&wP[2]) | (wG[0]&wP[3]&wP[2]&wP[1]) | (iC&wP[3]&wP[2]&wP[1]);
//    assign oC_array = wC[ADDER_WIDTH:1];
//    assign oSum = wC[ADDER_WIDTH-1:0] ^ wP;
//    assign oC = wC[ADDER_WIDTH];
//    assign G = wG;
//    assign P = wP;
//endmodule