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

module adder_128bit#(parameter ADDER_WIDTH = 128)(
    input  wire [ADDER_WIDTH-1:0] iA, iB,
    input  wire                   iC,
    output wire [ADDER_WIDTH-1:0] oSum,
    output wire                   oC    
);

    wire [3:0] C;
    wire [ADDER_WIDTH-33:0] oSum_buff_0, oSum_buff_1;
    wire [3:0] C_0,C_1;
    assign C_0[0] = C[0], C_1[0] = C[0];
    adder_32bit adder_32bit_inst(.iA(iA[31:0]),.iB(iB[31:0]),.iC(iC),.oSum(oSum[31:0]),.oC(C[0]));
    ////////////////////////////////////////////////////////////////////////
    // iC == 0
    adder_32bit adder_32bit_inst_0_0(.iA(iA[63:32]),.iB(iB[63:32]),.iC(0),.oSum(oSum_buff_0[31:0]),.oC(C_0[1]));
    // iC == 1
    adder_32bit adder_32bit_inst_0_1(.iA(iA[63:32]),.iB(iB[63:32]),.iC(1),.oSum(oSum_buff_1[31:0]),.oC(C_1[1]));
    assign C[1] = (C[0] == 1'b0) ? C_0[1] : C_1[1];
    assign oSum[63:32] = (C[0] == 1'b0) ? oSum_buff_0[31:0] : oSum_buff_1[31:0];
    ///////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////
    // iC == 0
    adder_32bit adder_32bit_inst_1_0(.iA(iA[95:64]),.iB(iB[95:64]),.iC(0),.oSum(oSum_buff_0[63:32]),.oC(C_0[2]));
    // iC == 1
    adder_32bit adder_32bit_inst_1_1(.iA(iA[95:64]),.iB(iB[95:64]),.iC(1),.oSum(oSum_buff_1[63:32]),.oC(C_1[2]));
    assign C[2] = (C[1] == 1'b0) ? C_0[2] : C_1[2];
    assign oSum[95:64] = (C[1] == 1'b0) ? oSum_buff_0[63:32] : oSum_buff_1[63:32];
    ///////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////
    // iC == 0
    adder_32bit adder_32bit_inst_2_0(.iA(iA[127:96]),.iB(iB[127:96]),.iC(0),.oSum(oSum_buff_0[95:64]),.oC(C_0[3]));
    // iC == 1
    adder_32bit adder_32bit_inst_2_1(.iA(iA[127:96]),.iB(iB[127:96]),.iC(1),.oSum(oSum_buff_1[95:64]),.oC(C_1[3]));
    assign C[3] = (C[2] == 1'b0) ? C_0[3] : C_1[3];
    assign oSum[127:96] = (C[2] == 1'b0) ? oSum_buff_0[95:64] : oSum_buff_1[95:64];
    ///////////////////////////////////////////////////////////////////////////
    assign oC = C[3];
endmodule