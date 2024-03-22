///////////////////////WNS == 1.617WHS == 0.244/////////////////
////module adder_16bit#(parameter ADDER_WIDTH = 16)(
////    input  wire [ADDER_WIDTH-1:0] iA, iB,
////    input  wire                   iC,
////    output wire [ADDER_WIDTH-1:0] oSum,
////    output wire [ADDER_WIDTH-1:0] G,P,
////    output wire                   oC    
////);

////    wire [ADDER_WIDTH/4:0] carries;
////    wire [ADDER_WIDTH-1:0] wG,wP;
////    assign carries[0] = iC;
////    genvar i;
////    generate
////        for (i=0; i<ADDER_WIDTH/4; i=i+1) begin
////        adder_4bit adder_4bit_inst (
////            .iA(iA[4*i+3:4*i]),
////            .iB(iB[4*i+3:4*i]),
////            .iC(carries[i]),
////            .oSum(oSum[4*i+3:4*i]),
////            .G(wG[4*i+3:4*i]),
////            .P(wP[4*i+3:4*i]),
////            .oC(carries[i+1])
////            //.oC(carries[i+1])
////        );
////        end 
////    endgenerate
    
////    Carry_lookahead_16bit Carry_lookahead_16bit_inst (
////        .G(wG),
////        .P(wP),
////        .iC(iC),
////        .oC(oC)
////    );
    
////    assign G  = wG;
////    assign P  = wP;
////endmodule

/////////////////////WNS == 1.526  WHS == 0.264/////////////////
////module adder_16bit#(parameter ADDER_WIDTH = 16)(
////    input  wire [ADDER_WIDTH-1:0] iA, iB,
////    input  wire                   iC,
////    output wire [ADDER_WIDTH-1:0] oSum,
////    output wire [ADDER_WIDTH-1:0] G,P,
////    output wire                   oC    
////);

////    wire [ADDER_WIDTH/4-2:0] wC, wC_0, wC_1;
////    wire [ADDER_WIDTH-1:0] wG,wP;
////    wire [(ADDER_WIDTH*3/4)-1:0] Sum_Buffer_0, Sum_Buffer_1;
////    adder_4bit adder_4bit_inst_1st (
////        .iA(iA[3:0]),
////        .iB(iB[3:0]),
////        .iC(iC),
////        .oSum(oSum[3:0]),
////        .G(wG[3:0]),
////        .P(wP[3:0]),
////        .oC(wC[0])
////    );
////    genvar i;
////    generate
////        for (i=1; i<ADDER_WIDTH/4; i=i+1) begin
////            //C=0
////            adder_4bit adder_4bit_inst (
////            .iA(iA[4*i+3:4*i]),
////            .iB(iB[4*i+3:4*i]),
////            .iC(0),
////            .oSum(Sum_Buffer_0[4*(i-1)+3:4*(i-1)]),
////            .G(wG[4*i+3:4*i]),
////            .P(wP[4*i+3:4*i]),
////            .oC(wC_0[i-1])
////        );
////        //C=1
////            adder_4bit adder_4bit_inst_1 (
////            .iA(iA[4*i+3:4*i]),
////            .iB(iB[4*i+3:4*i]),
////            .iC(1),
////            .oSum(Sum_Buffer_1[4*(i-1)+3:4*(i-1)]),
////            .oC(wC_1[i-1])
////        );
////        end 
////    endgenerate
////    assign wC[1] = (wC[0]==0) ? wC_0[0] : wC_1[0];
////    assign wC[2] = (wC[1]==0) ? wC_0[1] : wC_1[1];
////    assign oC = (wC[2]==0) ? wC_0[2] : wC_1[2];
////    assign oSum[7:4]   = (wC[0]==0) ? Sum_Buffer_0[3:0] : Sum_Buffer_1[3:0];
////    assign oSum[11:8]  = (wC[1]==0) ? Sum_Buffer_0[7:4] : Sum_Buffer_1[7:4];
////    assign oSum[15:12] = (wC[2]==0) ? Sum_Buffer_0[11:8] : Sum_Buffer_1[11:8];
////    assign G  = wG;
////    assign P  = wP;
////endmodule


//module adder_16bit#(parameter ADDER_WIDTH = 16)(
//    input  wire [ADDER_WIDTH-1:0] iA, iB,
//    input  wire                   iC,
//    output wire [ADDER_WIDTH-1:0] oSum,
//    output wire [ADDER_WIDTH-1:0] G,P,
//    output wire                   oC    
//);

//    wire [ADDER_WIDTH/4-1:0] wC, wC_0, wC_1;
//    wire [ADDER_WIDTH-1:0] wG,wP;
//    wire [ADDER_WIDTH/2-1:0] Sum_Buffer_0, Sum_Buffer_1;
//    adder_4bit adder_4bit_inst_1st (.iA(iA[3:0]),.iB(iB[3:0]),.iC(iC),.oSum(oSum[3:0]),.G(wG[3:0]),.P(wP[3:0]),.oC(wC[0]));
//    // 2nd
//    adder_4bit adder_4bit_inst_2nd (.iA(iA[7:4]),.iB(iB[7:4]),.iC(wC[0]),.oSum(oSum[7:4]),.G(wG[7:4]),.P(wP[7:4]),.oC(wC[1]));
//    ////////////////////////////////C=0/////////////////////////////
//    // 3rd 
//    adder_4bit adder_4bit_inst_3rd_0 (.iA(iA[11:8]),.iB(iB[11:8]),.iC(0),.oSum(Sum_Buffer_0[3:0]),.G(wG[11:8]),.P(wP[11:8]),.oC(wC_0[0]));
//    // 4th 
//    adder_4bit adder_4bit_inst_4th_0 (.iA(iA[15:12]),.iB(iB[15:12]),.iC(wC_0[0]),.oSum(Sum_Buffer_0[7:4]),.G(wG[15:12]),.P(wP[15:12]),.oC(wC_0[1]));
//    ////////////////////////////////C=1/////////////////////////////
//    // 3rd 
//    adder_4bit adder_4bit_inst_3rd_1 (.iA(iA[11:8]),.iB(iB[11:8]),.iC(1),.oSum(Sum_Buffer_1[3:0]),.oC(wC_1[0]));
//    // 4th 
//    adder_4bit adder_4bit_inst_4th_1 (.iA(iA[15:12]),.iB(iB[15:12]),.iC(wC_1[0]),.oSum(Sum_Buffer_1[7:4]),.oC(wC_1[1]));
//    /////////////////////////////////////////////////////////////
//    Carry_lookahead_16bit Carry_lookahead_16bit_inst (
//        .G(wG),
//        .P(wP),
//        .iC(iC),
//        .oC(oC)
//    );
//    Carry_lookahead_12bit Carry_lookahead_12bit_inst (
//        .G(wG[11:0]),
//        .P(wP[11:0]),
//        .iC(iC),
//        .oC(wC[3])
//    );
//    Carry_lookahead_8bit Carry_lookahead_8bit_inst (
//        .G(wG[7:0]),
//        .P(wP[7:0]),
//        .iC(iC),
//        .oC(wC[2])
//    );
//    //assign oC = (wC[2]==0) ? wC_0[1] : wC_1[1];
    
//    assign oSum[15:8] = (wC[2]==0) ? Sum_Buffer_0: Sum_Buffer_1;
//    assign G  = wG;
//    assign P  = wP;
//endmodule

//module adder_16bit#(parameter ADDER_WIDTH = 16)(
//    input  wire [ADDER_WIDTH-1:0] iA, iB,
//    input  wire                   iC,
//    output wire [ADDER_WIDTH-1:0] oSum,
//    output wire [ADDER_WIDTH-1:0] G,P,
//    output wire [ADDER_WIDTH-1:0] oC_array,
//    output wire                   oC    
//);

//    wire [ADDER_WIDTH/4-1:0] wC, wC_0, wC_1;
//    wire [ADDER_WIDTH-1:0] wG,wP;
//    wire [ADDER_WIDTH/2-1:0] Sum_Buffer_0, Sum_Buffer_1;
//    adder_4bit adder_4bit_inst_1st (.iA(iA[3:0]),.iB(iB[3:0]),.iC(iC),.oSum(oSum[3:0]),.G(wG[3:0]),.P(wP[3:0]),.oC(wC[0]));
//    // 2nd
//    adder_4bit adder_4bit_inst_2nd (.iA(iA[7:4]),.iB(iB[7:4]),.iC(wC[0]),.oSum(oSum[7:4]),.G(wG[7:4]),.P(wP[7:4]),.oC(wC[1]));
//    // 3rd 
//    adder_4bit adder_4bit_inst_3rd (.iA(iA[11:8]),.iB(iB[11:8]),.iC(wC[2]),.oSum(oSum[11:8]),.G(wG[11:8]),.P(wP[11:8]));
//    // 4th 
//    adder_4bit adder_4bit_inst_4th (.iA(iA[15:12]),.iB(iB[15:12]),.iC(wC[3]),.oSum(oSum[15:12]),.G(wG[15:12]),.P(wP[15:12]));

//    Carry_lookahead_8bit Carry_lookahead_8bit_inst (
//        .G(wG[7:0]),
//        .P(wP[7:0]),
//        .iC(iC),
//        .oC(wC[2])
//    );
//    Carry_lookahead_12bit Carry_lookahead_12bit_inst (
//        .G(wG[11:0]),
//        .P(wP[11:0]),
//        .iC(iC),
//        .oC(wC[3])
//    );
//    Carry_lookahead_16bit Carry_lookahead_16bit_inst (
//        .G(wG),
//        .P(wP),
//        .iC(iC),
//        .oC(oC)
//    );
//    //assign oC = (wC[2]==0) ? wC_0[1] : wC_1[1];
    
//    assign G  = wG;
//    assign P  = wP;
//endmodule

///////////////////WNS == 1.617WHS == 0.244/////////////////
module adder_16bit#(parameter ADDER_WIDTH = 16)(
    input  wire [ADDER_WIDTH-1:0] iA, iB,
    input  wire iC,
    output wire [ADDER_WIDTH-1:0] oSum,
    output wire [ADDER_WIDTH-1:0] G,
    output wire [ADDER_WIDTH-1:0] P,
    output wire [ADDER_WIDTH-1:0] oC_array,
    output wire oC
);
    wire [ADDER_WIDTH-1:0] wP;// = iA | iB;
    wire [ADDER_WIDTH-1:0] wS = iA ^ iB;
    wire [ADDER_WIDTH-1:0] wG;// = iA & iB;
    wire [ADDER_WIDTH:0] wC;
    assign wC[0] = iC;
    assign wC[1] =  |{wG[0], iC&wP[0]};
    assign wC[2] =  |{wG[1], &{wG[0], wP[1]}, &{iC,wP[1:0]}};
    assign wC[3] =  |{wG[2], &{wG[1], wP[2]}, &{wG[0], wP[2:1]},  &{iC,wP[2:0]}};
    assign wC[4] =  |{wG[3], &{wG[2], wP[3]}, &{wG[1], wP[3:2]},  &{wG[0], wP[3:1]},&{iC,wP[3:0]}};
    assign wC[5] =  |{wG[4], &{wG[3], wP[4]}, &{wG[2], wP[4:3]},  &{wG[1], wP[4:2]},  &{wG[0], wP[4:1]},  &{iC,wP[4:0]}};
    assign wC[6] =  |{wG[5], &{wG[4], wP[5]}, &{wG[3], wP[5:4]},  &{wG[2], wP[5:3]},  &{wG[1], wP[5:2]},  &{wG[0], wP[5:1]},  &{iC,wP[5:0]}};
    assign wC[7] =  |{wG[6], &{wG[5], wP[6]}, &{wG[4], wP[6:5]},  &{wG[3], wP[6:4]},  &{wG[2], wP[6:3]},  &{wG[1], wP[6:2]},  &{wG[0],wP[6:1]},  &{iC,wP[6:0]}};
    assign wC[8] =  |{wG[7], &{wG[6], wP[7]}, &{wG[5], wP[7:6]},  &{wG[4], wP[7:5]},  &{wG[3], wP[7:4]},  &{wG[2], wP[7:3]},  &{wG[1],wP[7:2]},  &{wG[0],wP[7:1]}, &{iC,wP[7:0]}};
    assign wC[9] =  |{wG[8], &{wG[7], wP[8]}, &{wG[6], wP[8:7]},  &{wG[5], wP[8:6]},  &{wG[4], wP[8:5]},  &{wG[3], wP[8:4]},  &{wG[2],wP[8:3]},  &{wG[1],wP[8:2]}, &{wG[0],wP[8:1]}, &{iC,wP[8:0]}};
    assign wC[10] = |{wG[9], &{wG[8], wP[9]}, &{wG[7], wP[9:8]},  &{wG[6], wP[9:7]},  &{wG[5], wP[9:6]},  &{wG[4], wP[9:5]},  &{wG[3],wP[9:4]},  &{wG[2],wP[9:3]}, &{wG[1],wP[9:2]}, &{wG[0],wP[9:1]}, &{iC,wP[9:0]}};
    assign wC[11] = |{wG[10],&{wG[9], wP[10]},&{wG[8], wP[10:9]}, &{wG[7], wP[10:8]}, &{wG[6], wP[10:7]}, &{wG[5], wP[10:6]}, &{wG[4],wP[10:5]}, &{wG[3],wP[10:4]},&{wG[2],wP[10:3]},&{wG[1],wP[10:2]},&{wG[0],wP[10:1]},&{iC,wP[10:0]}};
    assign wC[12] = |{wG[11],&{wG[10],wP[11]},&{wG[9], wP[11:10]},&{wG[8], wP[11:9]}, &{wG[7], wP[11:8]}, &{wG[6], wP[11:7]}, &{wG[5],wP[11:6]}, &{wG[4],wP[11:5]},&{wG[3],wP[11:4]},&{wG[2],wP[11:3]},&{wG[1],wP[11:2]},&{wG[0],wP[11:1]},&{iC,wP[11:0]}};
    assign wC[13] = |{wG[12],&{wG[11],wP[12]},&{wG[10],wP[12:11]},&{wG[9], wP[12:10]},&{wG[8], wP[12:9]}, &{wG[7], wP[12:8]}, &{wG[6],wP[12:7]}, &{wG[5],wP[12:6]},&{wG[4],wP[12:5]},&{wG[3],wP[12:4]},&{wG[2],wP[12:3]},&{wG[1],wP[12:2]},&{wG[0],wP[12:1]},&{iC,wP[12:0]}};
    assign wC[14] = |{wG[13],&{wG[12],wP[13]},&{wG[11],wP[13:12]},&{wG[10],wP[13:11]},&{wG[9], wP[13:10]},&{wG[8], wP[13:9]}, &{wG[7],wP[13:8]}, &{wG[6],wP[13:7]},&{wG[5],wP[13:6]},&{wG[4],wP[13:5]},&{wG[3],wP[13:4]},&{wG[2],wP[13:3]},&{wG[1],wP[13:2]},&{wG[0],wP[13:1]},&{iC,wP[13:0]}};
    assign wC[15] = |{wG[14],&{wG[13],wP[14]},&{wG[12],wP[14:13]},&{wG[11],wP[14:12]},&{wG[10],wP[14:11]},&{wG[9], wP[14:10]},&{wG[8],wP[14:9]}, &{wG[7],wP[14:8]},&{wG[6],wP[14:7]},&{wG[5],wP[14:6]},&{wG[4],wP[14:5]},&{wG[3],wP[14:4]},&{wG[2],wP[14:3]},&{wG[1],wP[14:2]},&{wG[0],wP[14:1]},&{iC,wP[14:0]}};
    assign wC[16] = |{wG[15],&{wG[14],wP[15]},&{wG[13],wP[15:14]},&{wG[12],wP[15:13]},&{wG[11],wP[15:12]},&{wG[10],wP[15:11]},&{wG[9],wP[15:10]},&{wG[8],wP[15:9]},&{wG[7],wP[15:8]},&{wG[6],wP[15:7]},&{wG[5],wP[15:6]},&{wG[4],wP[15:5]},&{wG[3],wP[15:4]},&{wG[2],wP[15:3]},&{wG[1],wP[15:2]},&{wG[0],wP[15:1]},&{iC,wP[15:0]}};
    genvar i;
    generate
        for (i=0; i<ADDER_WIDTH; i=i+1) begin
            assign oSum[i] = wC[i] ^ wS[i], P[i] = iA[i] | iB[i], wG[i] = iA[i] & iB[i];
        end 
    endgenerate
    assign oC = wC[ADDER_WIDTH];
    assign G = wG;
    assign P = wP;
endmodule