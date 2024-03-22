//module adder_64bit#(parameter ADDER_WIDTH = 64)(
//    input  wire [ADDER_WIDTH-1:0] iA, iB,
//    input  wire                   iC,
//    output wire [ADDER_WIDTH-1:0] oSum,
//    output wire                   oC    
//);

//    wire [ADDER_WIDTH/16:0] carries;
//    wire [ADDER_WIDTH-1:0] wG,wP;
//    assign carries[0] = iC;
//    genvar i;
//    generate
//        for (i=0; i<ADDER_WIDTH/16; i=i+1) begin
//        adder_16bit adder_16bit_inst (
//            .iA(iA[16*i+15:16*i]),
//            .iB(iB[16*i+15:16*i]),
//            .iC(carries[i]),
//            .oSum(oSum[16*i+15:16*i]),
//            .G(wG[16*i+15:16*i]),
//            .P(wP[16*i+15:16*i]),
//            .oC(carries[i+1])
//        );
        
////        Carry_lookahead_4bit Carry_lookahead_4bit_inst (
////             .G(wG[16*i+3:16*i]),
////             .P(wP[16*i+3:16*i]),
////             .iC(carries[i]),
////             .oC(carries[i+1])
////        );
//        end 
//    endgenerate
//    assign oC = carries[ADDER_WIDTH/16];
//endmodule

/////////////////////////WNS == 0.677////////////////////////
//module adder_64bit#(parameter ADDER_WIDTH = 64)(
//    input  wire [ADDER_WIDTH-1:0] iA, iB,
//    input  wire                   iC,
//    output wire [ADDER_WIDTH-1:0] oSum,
//    output wire                   oC    
//);

//    wire [ADDER_WIDTH/32:0] carries;
//    wire [ADDER_WIDTH-1:0] wG,wP;
//    assign carries[0] = iC;
//    genvar i;
//    generate
//        for (i=0; i<ADDER_WIDTH/32; i=i+1) begin
//        adder_32bit adder_32bit_inst (
//            .iA(iA[32*i+31:32*i]),
//            .iB(iB[32*i+31:32*i]),
//            .iC(carries[i]),
//            .oSum(oSum[32*i+31:32*i]),
//            .G(wG[32*i+31:32*i]),
//            .P(wP[32*i+31:32*i]),
//            .oC(carries[i+1])
//        );
        
////        Carry_lookahead_4bit Carry_lookahead_4bit_inst (
////             .G(wG[16*i+3:16*i]),
////             .P(wP[16*i+3:16*i]),
////             .iC(carries[i]),
////             .oC(carries[i+1])
////        );
//        end 
//    endgenerate
//    assign oC = carries[ADDER_WIDTH/32];
//endmodule

/////////////////////////WNS == 1.114 whs == 0.072////////////////////////
//module adder_64bit#(parameter ADDER_WIDTH = 64)(
//    input  wire [ADDER_WIDTH-1:0] iA, iB,
//    input  wire                   iC,
//    output wire [ADDER_WIDTH-1:0] oSum,
//    output wire                   oC    
//);

//    wire [ADDER_WIDTH-1:0] wG,wP;
//    wire [ADDER_WIDTH-17:0] Sum_buffer_1, Sum_buffer_0;
//    wire [3:0] C;
//    wire [1:0] tempC_2, tempC_3, tempC_4;
//    adder_16bit adder_16bit_inst(
//        .iA(iA[15:0]),
//        .iB(iB[15:0]),
//        .iC(iC),
//        .oSum(oSum[15:0]),
//        .G(wG[15:0]),
//        .P(wP[15:0]),
//        .oC(C[0])
//    );
//    // 2nd: C = 0
//    adder_16bit adder_16bit_2nd_0(
//        .iA(iA[31:16]),
//        .iB(iB[31:16]),
//        .iC(0),
//        .oSum(Sum_buffer_0[15:0]),
//        .G(wG[31:16]),
//        .P(wP[31:16]),
//        .oC(tempC_2[0])
//    );
//    // 2nd: C = 1
//    adder_16bit adder_16bit_2nd_1(
//        .iA(iA[31:16]),
//        .iB(iB[31:16]),
//        .iC(1),
//        .oSum(Sum_buffer_1[15:0]),
////        .G(wG[31:16]),
////        .P(wP[31:16]),
//        .oC(tempC_2[1])
//    );
//    // 3rd: C = 0
//    adder_16bit adder_16bit_3rd_0(
//        .iA(iA[47:32]),
//        .iB(iB[47:32]),
//        .iC(0),
//        .oSum(Sum_buffer_0[31:16]),
//        .G(wG[47:32]),
//        .P(wP[47:32]),
//        .oC(tempC_3[0])
//    );
//    // 3rd C = 1
//    adder_16bit adder_16bit_3rd_1(
//        .iA(iA[47:32]),
//        .iB(iB[47:32]),
//        .iC(1),
//        .oSum(Sum_buffer_1[31:16]),
////        .G(wG[31:16]),
////        .P(wP[31:16]),
//        .oC(tempC_3[1])
//    );
//    // 4th: C = 0
//    adder_16bit adder_16bit_4th_0(
//        .iA(iA[63:48]),
//        .iB(iB[63:48]),
//        .iC(0),
//        .oSum(Sum_buffer_0[47:32]),
//        .G(wG[63:48]),
//        .P(wP[63:48]),
//        .oC(tempC_4[0])
//    );
//    // 4th: C = 1
//    adder_16bit adder_16bit_4th_1(
//        .iA(iA[63:48]),
//        .iB(iB[63:48]),
//        .iC(1),
//        .oSum(Sum_buffer_1[47:32]),
////        .G(wG[31:16]),
////        .P(wP[31:16]),
//        .oC(tempC_4[1])
//    );
//    assign C[1] = (C[0] == 0) ? tempC_2[0] : tempC_2[1];
//    assign C[2] = (C[1] == 0) ? tempC_3[0] : tempC_3[1];
//    assign C[3] = (C[2] == 0) ? tempC_4[0] : tempC_4[1];
//    assign oC = C[3];
    
//    assign oSum[31:16] = (C[0] == 0) ? Sum_buffer_0[15:0] : Sum_buffer_1[15:0];
//    assign oSum[47:32] = (C[1] == 0) ? Sum_buffer_0[31:16] : Sum_buffer_1[31:16];
//    assign oSum[63:48] = (C[2] == 0) ? Sum_buffer_0[47:32] : Sum_buffer_1[47:32];
//endmodule

/////////////////////////////WNS == 1.243 whs == 0.121////////////////////////
//module adder_64bit#(parameter ADDER_WIDTH = 64)(
//    input  wire [ADDER_WIDTH-1:0] iA, iB,
//    input  wire                   iC,
//    output wire [ADDER_WIDTH-1:0] oSum,
//    output wire [ADDER_WIDTH-1:0] G,P,
//    output wire                   oC    
//);

//    wire [ADDER_WIDTH-1:0] wG,wP;
//    wire [ADDER_WIDTH/2-1:0] Sum_buffer_1, Sum_buffer_0;
//    wire C;
//    wire [1:0] tempC_2;
//    adder_32bit adder_32bit_inst(
//        .iA(iA[31:0]),
//        .iB(iB[31:0]),
//        .iC(iC),
//        .oSum(oSum[31:0]),
//        .G(wG[31:0]),
//        .P(wP[31:0]),
//        .oC(C)
//    );
    
//    // 2nd: C = 0
//    adder_32bit adder_32bit_2nd_0(
//        .iA(iA[63:32]),
//        .iB(iB[63:32]),
//        .iC(0),
//        .oSum(Sum_buffer_0),
//        .G(wG[63:32]),
//        .P(wP[63:32]),
//        .oC(tempC_2[0])
//    );
//    // 2nd: C = 1
//    adder_32bit adder_32bit_2nd_1(
//        .iA(iA[63:32]),
//        .iB(iB[63:32]),
//        .iC(1),
//        .oSum(Sum_buffer_1),
////        .G(wG[31:16]),
////        .P(wP[31:16]),
//        .oC(tempC_2[1])
//    );
//    assign G = wG;
//    assign P = wP;
//    assign oC = (C == 0) ? tempC_2[0] : tempC_2[1];
//    assign oSum[63:32] = (C == 0) ? Sum_buffer_0 : Sum_buffer_1;
//endmodule
//////////////////-2.785///////////////////
//module adder_64bit#(parameter ADDER_WIDTH = 64)(
//    input  wire [ADDER_WIDTH-1:0] iA, iB,
//    input  wire                   iC,
//    output wire [ADDER_WIDTH-1:0] oSum,
//    output wire [ADDER_WIDTH-1:0] G,P,
//    output wire                   oC    
//);
//    wire _C;
//    wire [ADDER_WIDTH/8-1:0] wC,wC_0,wC_1;
//    wire [ADDER_WIDTH/8*7-1:0] wBuffer_0, wBuffer_1;
//    adder_8bit adder_8bit_1st(.iA(iA[7:0]),.iB(iB[7:0]),.iC(iC),.oSum(oSum[7:0]),.oC(_C));
//    assign wC_0[0] = _C, wC_1[0] = _C, wC[0] = _C;
//    genvar i;
//    generate
//        for (i=1; i<ADDER_WIDTH/8; i=i+1) begin
//            adder_8bit adder_8bit_0(.iA(iA[8*i+7:8*i]),.iB(iB[8*i+7:8*i]),.iC(0),.oSum(wBuffer_0[8*(i-1)+7:8*(i-1)]),.oC(wC_0[i]));
//            adder_8bit adder_8bit_1(.iA(iA[8*i+7:8*i]),.iB(iB[8*i+7:8*i]),.iC(1),.oSum(wBuffer_1[8*(i-1)+7:8*(i-1)]),.oC(wC_1[i]));
//            assign wC[i]  = (wC[i-1]==0) ? wC_0[i] : wC_1[i];
//            assign oSum[8*i+7:8*i] = (wC[i-1]==0) ? wBuffer_0[8*(i-1)+7:8*(i-1)] : wBuffer_1[8*(i-1)+7:8*(i-1)];
//        end 
//    endgenerate
//    assign oC = wC[ADDER_WIDTH/8-1];
//endmodule

module adder_64bit#(parameter ADDER_WIDTH = 64)(
    input  wire [ADDER_WIDTH-1:0] iA, iB,
    input  wire                   iC,
    output wire [ADDER_WIDTH-1:0] oSum,
    output wire [ADDER_WIDTH-1:0] G,P,
    output wire                   oC    
);
    wire [14:0] wC_0,wC_1;
    wire [5:0]  wC;
    wire [ADDER_WIDTH-5:0] wBuffer_0, wBuffer_1;
    ///////////////////////////////////////////////////////////////////////////////////
    adder_4bit adder_4bit_1(.iA(iA[3:0]),.iB(iB[3:0]),.iC(iC),.oSum(oSum[3:0]),.oC(wC[0]));
    ////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////
    adder_4bit adder_4bit_2_0(.iA(iA[7:4]),.iB(iB[7:4]),.iC(0),.oSum(wBuffer_0[3:0]),.oC(wC_0[0]));
    adder_4bit adder_4bit_2_1(.iA(iA[7:4]),.iB(iB[7:4]),.iC(1),.oSum(wBuffer_1[3:0]),.oC(wC_1[0]));
    assign wC[1]  = (wC[0]==0) ? wC_0[0] : wC_1[0];
    assign oSum[7:4] = (wC[0]==0) ? wBuffer_0[3:0] : wBuffer_1[3:0];
    ////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////
    adder_4bit adder_4bit_3_0(.iA(iA[11:8]), .iB(iB[11:8]), .iC(0),      .oSum(wBuffer_0[7:4]), .oC(wC_0[1]));
    adder_4bit adder_4bit_3_2(.iA(iA[15:12]),.iB(iB[15:12]),.iC(wC_0[1]),.oSum(wBuffer_0[11:8]),.oC(wC_0[2]));
    
    adder_4bit adder_4bit_3_1(.iA(iA[11:8]), .iB(iB[11:8]), .iC(1),      .oSum(wBuffer_1[7:4]), .oC(wC_1[1]));
    adder_4bit adder_4bit_3_3(.iA(iA[15:12]),.iB(iB[15:12]),.iC(wC_1[1]),.oSum(wBuffer_1[11:8]),.oC(wC_1[2]));
    assign wC[2]  = (wC[1]==0) ? wC_0[2] : wC_1[2];
    assign oSum[15:8] = (wC[1]==0) ? wBuffer_0[11:4] : wBuffer_1[11:4];
    ////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////
    adder_4bit adder_4bit_4_0(.iA(iA[19:16]),.iB(iB[19:16]),.iC(0),      .oSum(wBuffer_0[15:12]),.oC(wC_0[3]));
    adder_4bit adder_4bit_4_2(.iA(iA[23:20]),.iB(iB[23:20]),.iC(wC_0[3]),.oSum(wBuffer_0[19:16]),.oC(wC_0[4]));
    adder_4bit adder_4bit_4_4(.iA(iA[27:24]),.iB(iB[27:24]),.iC(wC_0[4]),.oSum(wBuffer_0[23:20]),.oC(wC_0[5]));
    
    adder_4bit adder_4bit_4_1(.iA(iA[19:16]),.iB(iB[19:16]),.iC(1),      .oSum(wBuffer_1[15:12]),.oC(wC_1[3]));
    adder_4bit adder_4bit_4_3(.iA(iA[23:20]),.iB(iB[23:20]),.iC(wC_1[3]),.oSum(wBuffer_1[19:16]),.oC(wC_1[4]));
    adder_4bit adder_4bit_4_5(.iA(iA[27:24]),.iB(iB[27:24]),.iC(wC_1[4]),.oSum(wBuffer_1[23:20]),.oC(wC_1[5]));
    assign wC[3]  = (wC[2]==0) ? wC_0[5] : wC_1[5];
    assign oSum[27:16] = (wC[2]==0) ? wBuffer_0[23:12] : wBuffer_1[23:12];
    ////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////
    adder_4bit adder_4bit_5_0(.iA(iA[31:28]),.iB(iB[31:28]),.iC(0),      .oSum(wBuffer_0[27:24]),.oC(wC_0[6]));
    adder_4bit adder_4bit_5_2(.iA(iA[35:32]),.iB(iB[35:32]),.iC(wC_0[6]),.oSum(wBuffer_0[31:28]),.oC(wC_0[7]));
    adder_4bit adder_4bit_5_4(.iA(iA[39:36]),.iB(iB[39:36]),.iC(wC_0[7]),.oSum(wBuffer_0[35:32]),.oC(wC_0[8]));
    adder_4bit adder_4bit_5_6(.iA(iA[43:40]),.iB(iB[43:40]),.iC(wC_0[8]),.oSum(wBuffer_0[39:36]),.oC(wC_0[9]));
    
    adder_4bit adder_4bit_5_1(.iA(iA[31:28]),.iB(iB[31:28]),.iC(1),      .oSum(wBuffer_1[27:24]),.oC(wC_1[6]));
    adder_4bit adder_4bit_5_3(.iA(iA[35:32]),.iB(iB[35:32]),.iC(wC_1[6]),.oSum(wBuffer_1[31:28]),.oC(wC_1[7]));
    adder_4bit adder_4bit_5_5(.iA(iA[39:36]),.iB(iB[39:36]),.iC(wC_1[7]),.oSum(wBuffer_1[35:32]),.oC(wC_1[8]));
    adder_4bit adder_4bit_5_7(.iA(iA[43:40]),.iB(iB[43:40]),.iC(wC_1[8]),.oSum(wBuffer_1[39:36]),.oC(wC_1[9]));
    assign wC[4]  = (wC[3]==0) ? wC_0[9] : wC_1[9];
    assign oSum[43:28] = (wC[3]==0) ? wBuffer_0[39:24] : wBuffer_1[39:24];
    ////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////
    adder_4bit adder_4bit_6_0(.iA(iA[47:44]),.iB(iB[47:44]),.iC(0),       .oSum(wBuffer_0[43:40]),.oC(wC_0[10]));
    adder_4bit adder_4bit_6_2(.iA(iA[51:48]),.iB(iB[51:48]),.iC(wC_0[10]),.oSum(wBuffer_0[47:44]),.oC(wC_0[11]));
    adder_4bit adder_4bit_6_4(.iA(iA[55:52]),.iB(iB[55:52]),.iC(wC_0[11]),.oSum(wBuffer_0[51:48]),.oC(wC_0[12]));
    adder_4bit adder_4bit_6_6(.iA(iA[59:56]),.iB(iB[59:56]),.iC(wC_0[12]),.oSum(wBuffer_0[55:52]),.oC(wC_0[13]));
    adder_4bit adder_4bit_6_8(.iA(iA[63:60]),.iB(iB[63:60]),.iC(wC_0[13]),.oSum(wBuffer_0[59:56]),.oC(wC_0[14]));
    
    adder_4bit adder_4bit_6_1(.iA(iA[47:44]),.iB(iB[47:44]),.iC(1),       .oSum(wBuffer_1[43:40]),.oC(wC_1[10]));
    adder_4bit adder_4bit_6_3(.iA(iA[51:48]),.iB(iB[51:48]),.iC(wC_1[10]),.oSum(wBuffer_1[47:44]),.oC(wC_1[11]));
    adder_4bit adder_4bit_6_5(.iA(iA[55:52]),.iB(iB[55:52]),.iC(wC_1[11]),.oSum(wBuffer_1[51:48]),.oC(wC_1[12]));
    adder_4bit adder_4bit_6_7(.iA(iA[59:56]),.iB(iB[59:56]),.iC(wC_1[12]),.oSum(wBuffer_1[55:52]),.oC(wC_1[13]));
    adder_4bit adder_4bit_6_9(.iA(iA[63:60]),.iB(iB[63:60]),.iC(wC_1[13]),.oSum(wBuffer_1[59:56]),.oC(wC_1[14]));
    assign wC[5]  = (wC[4]==0) ? wC_0[14] : wC_1[14];
    assign oSum[63:44] = (wC[4]==0) ? wBuffer_0[59:40] : wBuffer_1[59:40];
    ////////////////////////////////////////////////////////////////////////////////////
    assign oC = wC[5];
endmodule

//module adder_128bit#(parameter ADDER_WIDTH = 128)(
//    input  wire [ADDER_WIDTH-1:0] iA, iB,
//    input  wire                   iC,
//    output wire [ADDER_WIDTH-1:0] oSum,
//    output wire [ADDER_WIDTH-1:0] G,P,
//    output wire                   oC    
//);
//    wire [14:0] wC_0,wC_1;
//    wire [5:0]  wC;
//    wire [ADDER_WIDTH-9:0] wBuffer_0, wBuffer_1;
//    ///////////////////////////////////////////////////////////////////////////////////
//    adder_8bit adder_8bit_1(.iA(iA[7:0]),.iB(iB[7:0]),.iC(iC),.oSum(oSum[7:0]),.oC(wC[0]));
//    ////////////////////////////////////////////////////////////////////////////////////
//    ///////////////////////////////////////////////////////////////////////////////////
//    adder_8bit adder_8bit_2_0(.iA(iA[15:8]),.iB(iB[15:8]),.iC(0),.oSum(wBuffer_0[7:0]),.oC(wC_0[0]));
//    adder_8bit adder_8bit_2_1(.iA(iA[15:8]),.iB(iB[15:8]),.iC(1),.oSum(wBuffer_1[7:0]),.oC(wC_1[0]));
//    assign wC[1]  = (wC[0]==0) ? wC_0[0] : wC_1[0];
//    assign oSum[15:8] = (wC[0]==0) ? wBuffer_0[7:0] : wBuffer_1[7:0];
//    ////////////////////////////////////////////////////////////////////////////////////
//    ///////////////////////////////////////////////////////////////////////////////////
//    adder_8bit adder_8bit_3_0(.iA(iA[23:16]), .iB(iB[23:16]), .iC(0),      .oSum(wBuffer_0[15:8]), .oC(wC_0[1]));
//    adder_8bit adder_8bit_3_2(.iA(iA[31:24]),.iB(iB[31:24]),.iC(wC_0[1]),.oSum(wBuffer_0[23:16]),.oC(wC_0[2]));
    
//    adder_8bit adder_8bit_3_1(.iA(iA[23:16]), .iB(iB[23:16]), .iC(1),      .oSum(wBuffer_1[15:8]), .oC(wC_1[1]));
//    adder_8bit adder_8bit_3_3(.iA(iA[31:24]),.iB(iB[31:24]),.iC(wC_1[1]),.oSum(wBuffer_1[23:16]),.oC(wC_1[2]));
//    assign wC[2]  = (wC[1]==0) ? wC_0[2] : wC_1[2];
//    assign oSum[31:16] = (wC[1]==0) ? wBuffer_0[23:8] : wBuffer_1[23:8];
//    ////////////////////////////////////////////////////////////////////////////////////
//    ///////////////////////////////////////////////////////////////////////////////////
//    adder_8bit adder_8bit_4_0(.iA(iA[39:32]),.iB(iB[39:32]),.iC(0),      .oSum(wBuffer_0[31:24]),.oC(wC_0[3]));
//    adder_8bit adder_8bit_4_2(.iA(iA[47:40]),.iB(iB[47:40]),.iC(wC_0[3]),.oSum(wBuffer_0[39:32]),.oC(wC_0[4]));
//    adder_8bit adder_8bit_4_4(.iA(iA[55:48]),.iB(iB[55:48]),.iC(wC_0[4]),.oSum(wBuffer_0[47:40]),.oC(wC_0[5]));
    
//    adder_8bit adder_8bit_4_1(.iA(iA[39:32]),.iB(iB[39:32]),.iC(1),      .oSum(wBuffer_1[31:24]),.oC(wC_1[3]));
//    adder_8bit adder_8bit_4_3(.iA(iA[47:40]),.iB(iB[47:40]),.iC(wC_1[3]),.oSum(wBuffer_1[39:32]),.oC(wC_1[4]));
//    adder_8bit adder_8bit_4_5(.iA(iA[55:48]),.iB(iB[55:48]),.iC(wC_1[4]),.oSum(wBuffer_1[47:40]),.oC(wC_1[5]));
//    assign wC[3]  = (wC[2]==0) ? wC_0[5] : wC_1[5];
//    assign oSum[55:32] = (wC[2]==0) ? wBuffer_0[47:24] : wBuffer_1[47:24];
//    ////////////////////////////////////////////////////////////////////////////////////
//    ///////////////////////////////////////////////////////////////////////////////////
//    adder_8bit adder_8bit_5_0(.iA(iA[63:56]),.iB(iB[63:56]),.iC(0),      .oSum(wBuffer_0[55:48]),.oC(wC_0[6]));
//    adder_8bit adder_8bit_5_2(.iA(iA[71:64]),.iB(iB[71:64]),.iC(wC_0[6]),.oSum(wBuffer_0[63:56]),.oC(wC_0[7]));
//    adder_8bit adder_8bit_5_4(.iA(iA[79:72]),.iB(iB[79:72]),.iC(wC_0[7]),.oSum(wBuffer_0[71:64]),.oC(wC_0[8]));
//    adder_8bit adder_8bit_5_6(.iA(iA[87:80]),.iB(iB[87:80]),.iC(wC_0[8]),.oSum(wBuffer_0[79:72]),.oC(wC_0[9]));
    
//    adder_8bit adder_8bit_5_1(.iA(iA[63:56]),.iB(iB[63:56]),.iC(1),      .oSum(wBuffer_1[55:48]),.oC(wC_1[6]));
//    adder_8bit adder_8bit_5_3(.iA(iA[71:64]),.iB(iB[71:64]),.iC(wC_1[6]),.oSum(wBuffer_1[63:56]),.oC(wC_1[7]));
//    adder_8bit adder_8bit_5_5(.iA(iA[79:72]),.iB(iB[79:72]),.iC(wC_1[7]),.oSum(wBuffer_1[71:64]),.oC(wC_1[8]));
//    adder_8bit adder_8bit_5_7(.iA(iA[87:80]),.iB(iB[87:80]),.iC(wC_1[8]),.oSum(wBuffer_1[79:72]),.oC(wC_1[9]));
//    assign wC[4]  = (wC[3]==0) ? wC_0[9] : wC_1[9];
//    assign oSum[87:56] = (wC[3]==0) ? wBuffer_0[79:48] : wBuffer_1[79:48];
//    ////////////////////////////////////////////////////////////////////////////////////
//    ///////////////////////////////////////////////////////////////////////////////////
//    adder_8bit adder_8bit_6_0(.iA(iA[95:88]),.iB(iB[95:88]),.iC(0),       .oSum(wBuffer_0[87:80]),.oC(wC_0[10]));
//    adder_8bit adder_8bit_6_2(.iA(iA[103:96]),.iB(iB[103:96]),.iC(wC_0[10]),.oSum(wBuffer_0[95:88]),.oC(wC_0[11]));
//    adder_8bit adder_8bit_6_4(.iA(iA[111:104]),.iB(iB[111:104]),.iC(wC_0[11]),.oSum(wBuffer_0[103:96]),.oC(wC_0[12]));
//    adder_8bit adder_8bit_6_6(.iA(iA[119:112]),.iB(iB[119:112]),.iC(wC_0[12]),.oSum(wBuffer_0[111:104]),.oC(wC_0[13]));
//    adder_8bit adder_8bit_6_8(.iA(iA[127:120]),.iB(iB[127:120]),.iC(wC_0[13]),.oSum(wBuffer_0[119:112]),.oC(wC_0[14]));
    
//    adder_8bit adder_8bit_6_1(.iA(iA[95:88]),.iB(iB[95:88]),.iC(1),       .oSum(wBuffer_1[87:80]),.oC(wC_1[10]));
//    adder_8bit adder_8bit_6_3(.iA(iA[103:96]),.iB(iB[103:96]),.iC(wC_1[10]),.oSum(wBuffer_1[95:88]),.oC(wC_1[11]));
//    adder_8bit adder_8bit_6_5(.iA(iA[111:104]),.iB(iB[111:104]),.iC(wC_1[11]),.oSum(wBuffer_1[103:96]),.oC(wC_1[12]));
//    adder_8bit adder_8bit_6_7(.iA(iA[119:112]),.iB(iB[119:112]),.iC(wC_1[12]),.oSum(wBuffer_1[111:104]),.oC(wC_1[13]));
//    adder_8bit adder_8bit_6_9(.iA(iA[127:120]),.iB(iB[127:120]),.iC(wC_1[13]),.oSum(wBuffer_1[119:112]),.oC(wC_1[14]));
//    assign wC[5]  = (wC[4]==0) ? wC_0[14] : wC_1[14];
//    assign oSum[127:88] = (wC[4]==0) ? wBuffer_0[119:80] : wBuffer_1[119:80];
//    ////////////////////////////////////////////////////////////////////////////////////
//    assign oC = wC[5];
//endmodule