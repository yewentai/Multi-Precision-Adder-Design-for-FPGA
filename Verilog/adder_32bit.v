module adder_32bit#(parameter ADDER_WIDTH = 32)(
    input  wire [ADDER_WIDTH-1:0] iA, iB,
    input  wire                   iC,
    output wire [ADDER_WIDTH-1:0] oSum,
    output wire                   oC    
);

    wire [3:0] C;
    wire [ADDER_WIDTH-9:0] oSum_buff_0, oSum_buff_1;
    wire [ADDER_WIDTH-1:0] C_0,C_1;
    assign C_0[0] = C[0], C_1[0] = C[0];
    adder_8bit adder_8bit_inst(.iA(iA[7:0]),.iB(iB[7:0]),.iC(iC),.oSum(oSum[7:0]),.oC(C[0]));
    ////////////////////////////////////////////////////////////////////////
    // iC == 0
    adder_8bit adder_8bit_inst_0_0(.iA(iA[15:8]),.iB(iB[15:8]),.iC(0),.oSum(oSum_buff_0[7:0]),.oC(C_0[1]));
    // iC == 1
    adder_8bit adder_8bit_inst_0_1(.iA(iA[15:8]),.iB(iB[15:8]),.iC(1),.oSum(oSum_buff_1[7:0]),.oC(C_1[1]));
    assign C[1] = (C[0] == 1'b0) ? C_0[1] : C_1[1];
    assign oSum[15:8] = (C[0] == 1'b0) ? oSum_buff_0[7:0] : oSum_buff_1[7:0];
    ///////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////
    // iC == 0
    adder_8bit adder_8bit_inst_1_0(.iA(iA[23:16]),.iB(iB[23:16]),.iC(0),.oSum(oSum_buff_0[15:8]),.oC(C_0[2]));
    // iC == 1
    adder_8bit adder_8bit_inst_1_1(.iA(iA[23:16]),.iB(iB[23:16]),.iC(1),.oSum(oSum_buff_1[15:8]),.oC(C_1[2]));
    assign C[2] = (C[1] == 1'b0) ? C_0[2] : C_1[2];
    assign oSum[23:16] = (C[1] == 1'b0) ? oSum_buff_0[15:8] : oSum_buff_1[15:8];
    ///////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////
    // iC == 0
    adder_8bit adder_8bit_inst_2_0(.iA(iA[31:24]),.iB(iB[31:24]),.iC(0),.oSum(oSum_buff_0[23:16]),.oC(C_0[3]));
    // iC == 1
    adder_8bit adder_8bit_inst_2_1(.iA(iA[31:24]),.iB(iB[31:24]),.iC(1),.oSum(oSum_buff_1[23:16]),.oC(C_1[3]));
    assign C[3] = (C[2] == 1'b0) ? C_0[3] : C_1[3];
    assign oSum[31:24] = (C[2] == 1'b0) ? oSum_buff_0[23:16] : oSum_buff_1[23:16];
    ///////////////////////////////////////////////////////////////////////////
    assign oC = C[3];
endmodule