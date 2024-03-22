//module comparator_512bit#(parameter OPERATOR_WIDTH = 512)(
//    input  wire [OPERATOR_WIDTH-1:0] diff,iA,
//    output wire [2:0] oRes
//);
//    wire [OPERATOR_WIDTH/8-1:0] L1;
//    wire [OPERATOR_WIDTH/8/8-1:0] L2, L1_buff, A_sub, diff_buff_2;
//    genvar i;
//    generate
//        for (i=0; i<OPERATOR_WIDTH/8; i=i+1) begin
//            assign L1[i] = |diff[i*8+7:i*8];
//        end
//    endgenerate
//    generate
//        for (i=0; i<OPERATOR_WIDTH/8/8; i=i+1) begin
//            assign L2[i] = |L1[i*8+7:i*8];
//        end
//    endgenerate
//    //////////////////////////////////////////////// 
//    assign L1_buff = (L2[7]==1) ? L1[63:56] :
//                     (L2[6]==1) ? L1[55:48] :
//                     (L2[5]==1) ? L1[47:40] :
//                     (L2[4]==1) ? L1[39:32] :
//                     (L2[3]==1) ? L1[31:24] :
//                     (L2[2]==1) ? L1[23:16] :
//                     (L2[1]==1) ? L1[15:8] : L1[7:0];
//    wire[127:0] buff = (L2[7]==1) ? {diff[511:448],iA[511:448]} :    
//                       (L2[6]==1) ? {diff[447:384],iA[447:384]} :    
//                       (L2[5]==1) ? {diff[383:320],iA[383:320]} :    
//                       (L2[4]==1) ? {diff[319:256],iA[319:256]} :    
//                       (L2[3]==1) ? {diff[255:192],iA[255:192]} :    
//                       (L2[2]==1) ? {diff[191:128],iA[191:128]} :    
//                       (L2[1]==1) ? {diff[127:64] ,iA[127:64] } : {diff[63:0],iA[63:0]};
//    assign A_sub = (L1_buff[7]==1) ? buff[63:56] :    
//                   (L1_buff[6]==1) ? buff[55:48] :    
//                   (L1_buff[5]==1) ? buff[47:40] :    
//                   (L1_buff[4]==1) ? buff[39:32] :    
//                   (L1_buff[3]==1) ? buff[31:24] :    
//                   (L1_buff[2]==1) ? buff[23:16] :    
//                   (L1_buff[1]==1) ? buff[15:8] : buff[7:0];
//    assign diff_buff_2 = (L1_buff[7]==1) ? buff[63+64:56+64] :    
//                         (L1_buff[6]==1) ? buff[55+64:48+64] :    
//                         (L1_buff[5]==1) ? buff[47+64:40+64] :    
//                         (L1_buff[4]==1) ? buff[39+64:32+64] :    
//                         (L1_buff[3]==1) ? buff[31+64:24+64] :    
//                         (L1_buff[2]==1) ? buff[23+64:16+64] :    
//                         (L1_buff[1]==1) ? buff[15+64:8+64] : buff[7+64:0+64];
//    assign diff_buff_2 = (L1_buff[7]==1) ? buff[63+64:56+64] :    
//                         (L1_buff[6]==1) ? buff[55+64:48+64] :    
//                         (L1_buff[5]==1) ? buff[47+64:40+64] :    
//                         (L1_buff[4]==1) ? buff[39+64:32+64] :    
//                         (L1_buff[3]==1) ? buff[31+64:24+64] :    
//                         (L1_buff[2]==1) ? buff[23+64:16+64] :    
//                         (L1_buff[1]==1) ? buff[15+64:8+64] : buff[7+64:0+64];
////    wire A_1 = (diff_buff_2[7] == 1) ? A_sub[7] :
////               (diff_buff_2[6] == 1) ? A_sub[6] : 
////               (diff_buff_2[5] == 1) ? A_sub[5] : 
////               (diff_buff_2[4] == 1) ? A_sub[4] : 
////               (diff_buff_2[3] == 1) ? A_sub[3] : 
////               (diff_buff_2[2] == 1) ? A_sub[2] : 
////               (diff_buff_2[1] == 1) ? A_sub[1] : A_sub[0]; // -0.221
//    wire A_1 = |{&{A_sub[7],diff_buff_2[7]},
//                 &{A_sub[6],~diff_buff_2[7],diff_buff_2[6]},
//                 &{A_sub[5],~diff_buff_2[7:6],diff_buff_2[5]},
//                 &{A_sub[4],~diff_buff_2[7:5],diff_buff_2[4]},
//                 &{A_sub[3],~diff_buff_2[7:4],diff_buff_2[3]},
//                 &{A_sub[2],~diff_buff_2[7:3],diff_buff_2[2]},
//                 &{A_sub[1],~diff_buff_2[7:2],diff_buff_2[1]},
//                 &{A_sub[0],~diff_buff_2[7:1],diff_buff_2[0]}};
//    assign oRes = {A_1&{|L2},|L2,~A_1&{|L2}};
//endmodule

//module comparator_512bit#(parameter OPERATOR_WIDTH = 512)(
//    input  wire [OPERATOR_WIDTH-1:0] diff,iA,
//    output wire [2:0] oRes
//);
//    wire [OPERATOR_WIDTH/8-1:0] L1;
//    wire [OPERATOR_WIDTH/8/8-1:0] L2;
//    genvar i;
//    generate
//        for (i=0; i<OPERATOR_WIDTH/8; i=i+1) begin
//            assign L1[i] = |diff[i*8+7:i*8];
//        end
//    endgenerate
//    generate
//        for (i=0; i<OPERATOR_WIDTH/8/8; i=i+1) begin
//            assign L2[i] = |L1[i*8+7:i*8];
//        end
//    endgenerate
//    //////////////////////////////////////////////// 
//    reg A_1;
//    reg [2:0] rRes;
//    reg [3:0] L2_4, L1_4, A_4, d_4;
//    reg [1:0] L2_2, L1_2, A_2, d_2;
//    reg [31:0] L1_32, A_32, d_32;
//    reg [15:0] L1_16, A_16, d_16;
//    reg [7:0]  L1_8, A_8, d_8;
//    reg [255:0] A_256, d_256;
//    reg [127:0] A_128, d_128;
//    reg [63:0] A_64, d_64;
//    always @(*) begin
//             if (|L2[7:4] == 1)   begin L2_4 = L2[7:4]; L1_32 = L1[63:32]; A_256 = iA[511:256]; d_256 = diff[511:256]; end
//        else                      begin L2_4 = L2[3:0]; L1_32 = L1[31:0];  A_256 = iA[255:0];   d_256 = diff[255:0];   end
//             if (|L2_4[3:2] == 1) begin L2_2 = L2_4[3:2]; L1_16 = L1[31:16]; A_128 = A_256[255:128]; d_128 = d_256[255:128]; end
//        else                      begin L2_2 = L2_4[1:0]; L1_16 = L1[15:0];  A_128 = A_256[127:0];   d_128 = d_256[127:0];   end
//             if (|L2_2[1] == 1)   begin L1_8 = L1[15:8]; A_64 = A_128[127:64]; d_64 = d_128[127:64]; end
//        else                      begin L1_8 = L1[7:0];  A_64 = A_128[63:0];   d_64 = d_128[63:0];   end
 
//             if (|L1_8[7:4] == 1) begin L1_4 = L1_8[7:4];   A_32 = A_64[63:32]; d_32 = d_64[63:32];  end
//        else                      begin L1_4 = L1_8[3:0];   A_32 = A_64[31:0];  d_32 = d_64[31:0];   end
//             if (|L1_4[3:2] == 1) begin L1_2 = L1_4[3:2]; A_16 = A_32[31:16]; d_16 = d_32[31:16];  end
//        else                      begin L1_2 = L1_4[1:0]; A_16 = A_32[15:0];  d_16 = d_32[15:0];   end
//             if (|L1_2[1] == 1)   begin A_8 = A_16[15:8]; d_8 = d_16[15:8]; end
//        else                      begin A_8 = A_16[7:0];  d_8 = d_16[7:0];  end
        
//             if (|d_8[7:4] == 1) begin A_4 = A_8[7:3]; d_4 = d_8[7:3];  end
//        else                     begin A_4 = A_8[4:0]; d_4 = d_8[4:0];  end
//             if (|d_4[3:2] == 1) begin A_2 = A_4[3:2]; d_2 = d_4[3:2];  end
//        else                     begin A_2 = A_4[1:0]; d_2 = d_4[1:0];  end
//             if (|d_2[1] == 1)   begin A_1 = A_2[1]; end
//        else                     begin A_1 = A_2[0]; end
        
//             if (|L2 == 0) rRes = 3'b010 ;
//        else if (A_1 == 1) rRes = 3'b100 ;
//        else if (A_1 == 0) rRes = 3'b001 ;
//        else               rRes = 3'b000 ;
//    end
//    assign oRes = rRes;
//endmodule

//module comparator_512bit#(parameter OPERATOR_WIDTH = 512)(
//    input  wire [OPERATOR_WIDTH-1:0] diff,iA,
//    output wire [2:0] oRes
//);
//    wire [OPERATOR_WIDTH/16-1:0] L1;
//    wire [OPERATOR_WIDTH/16/16-1:0] L2;
//    genvar i;
//    generate
//        for (i=0; i<OPERATOR_WIDTH/16; i=i+1) begin
//            assign L1[i] = |diff[i*16+15:i*16];
//        end
//    endgenerate
//    generate
//        for (i=0; i<OPERATOR_WIDTH/16/16; i=i+1) begin
//            assign L2[i] = |L1[i*16+15:i*16];
//        end
//    endgenerate
//    //////////////////////////////////////////////// 
//     reg [OPERATOR_WIDTH/16/16-1:0] A_sub, diff_buff_2;
//     reg [OPERATOR_WIDTH/16/2-1:0] L_1; //16
//     reg [OPERATOR_WIDTH/16/4-1:0] L_2; //8
//     reg [OPERATOR_WIDTH/16/8-1:0] L_3; //4
//     reg [OPERATOR_WIDTH/16/16-1:0]L_4; //4
//     reg [OPERATOR_WIDTH-1:0]   buff; //256+256
//     reg [OPERATOR_WIDTH/2-1:0] buff_1;//128+128
//     reg [OPERATOR_WIDTH/4-1:0] buff_2;//64+64
//     reg [OPERATOR_WIDTH/8-1:0] buff_3;//32+32
//     reg A_1;
//     reg [2:0] rRes;
//    always @(*) begin
//             if (L2[1]==1)      begin L_1 = L1[31:16]; buff = {diff[511:256],iA[511:256]}; end
//        else if (L2[0]==1)      begin L_1 = L1[15:0];  buff = {diff[255:0],iA[255:0]};     end
//             if (|L_1[15:8]==1) begin L_2 = L_1[15:8]; buff_1 = {buff[511:384],buff[255:128]}; end
//        else                    begin L_2 = L_1[7:0];  buff_1 = {buff[383:256],buff[127:0]};   end
//             if (|L_2[7:4]==1)  begin L_3 = L_2[7:4];  buff_2 = {buff_1[255:192],buff_1[127:64]}; end
//        else                    begin L_3 = L_2[3:0];  buff_2 = {buff_1[191:128],buff_1[63:0]};   end
//             if (|L_3[3:2]==1)  begin L_4 = L_3[3:2];  buff_3 = {buff_2[127:96],buff_2[63:32]}; end
//        else                    begin L_4 = L_3[1:0];  buff_3 = {buff_2[95:64],buff_2[31:0]};   end
//             if (|L_4[1]==1)    begin L_4 = L_3[3:2];  buff_3 = {buff_2[127:96],buff_2[63:32]}; end
//        else                    begin L_4 = L_3[1:0];  buff_3 = {buff_2[95:64],buff_2[31:0]};   end
//             if (L_1[7]==1) A_sub = buff[63:56] ;    
//        else if (L_1[6]==1) A_sub = buff[55:48] ;    
//        else if (L_1[5]==1) A_sub = buff[47:40] ;    
//        else if (L_1[4]==1) A_sub = buff[39:32] ;    
//        else if (L_1[3]==1) A_sub = buff[31:24] ;    
//        else if (L_1[2]==1) A_sub = buff[23:16] ;    
//        else if (L_1[1]==1) A_sub = buff[15:8]  ;
//        else                    A_sub = buff[7:0]   ;
//             if (L_1[7]==1) diff_buff_2 = buff[63+64:56+64] ;   
//        else if (L_1[6]==1) diff_buff_2 = buff[55+64:48+64] ;   
//        else if (L_1[5]==1) diff_buff_2 = buff[47+64:40+64] ;   
//        else if (L_1[4]==1) diff_buff_2 = buff[39+64:32+64] ;   
//        else if (L_1[3]==1) diff_buff_2 = buff[31+64:24+64] ;   
//        else if (L_1[2]==1) diff_buff_2 = buff[23+64:16+64] ;   
//        else if (L_1[1]==1) diff_buff_2 = buff[15+64:8+64]  ;
//        else                    diff_buff_2 = buff[7+64:0+64]   ;   
//             if (diff_buff_2[7] == 1) A_1 = A_sub[7] ;   
//        else if (diff_buff_2[6] == 1) A_1 = A_sub[6] ;   
//        else if (diff_buff_2[5] == 1) A_1 = A_sub[5] ;   
//        else if (diff_buff_2[4] == 1) A_1 = A_sub[4] ;   
//        else if (diff_buff_2[3] == 1) A_1 = A_sub[3] ;   
//        else if (diff_buff_2[2] == 1) A_1 = A_sub[2] ;   
//        else if (diff_buff_2[1] == 1) A_1 = A_sub[1] ;
//        else                          A_1 = A_sub[0] ;
//             if (|L2 == 0) rRes = 3'b010;
//        else if (A_1 == 1) rRes = 3'b100;
//        else if (A_1 == 0) rRes = 3'b001;
//        else               rRes = 3'b000;
//    end
//                       // -0.221
////    wire A_1 = |{&{A_sub[7],diff_buff_2[7]},
////                 &{A_sub[6],~diff_buff_2[7],diff_buff_2[6]},
////                 &{A_sub[5],~diff_buff_2[7:6],diff_buff_2[5]},
////                 &{A_sub[4],~diff_buff_2[7:5],diff_buff_2[4]},
////                 &{A_sub[3],~diff_buff_2[7:4],diff_buff_2[3]},
////                 &{A_sub[2],~diff_buff_2[7:3],diff_buff_2[2]},
////                 &{A_sub[1],~diff_buff_2[7:2],diff_buff_2[1]},
////                 &{A_sub[0],~diff_buff_2[7:1],diff_buff_2[0]}};
//    assign oRes = rRes;
//endmodule

module comparator_512bit#(parameter OPERATOR_WIDTH = 512)(
    input  wire [OPERATOR_WIDTH-1:0] diff,iA,
    output wire [2:0] oRes
);
    wire [OPERATOR_WIDTH/8-1:0] L1;
    wire [OPERATOR_WIDTH/8/8-1:0] L2, L1_buff, A_sub, diff_buff_2;
    wire [63:0] A;
    genvar i;
    generate
        for (i=0; i<OPERATOR_WIDTH/8; i=i+1) begin
            assign L1[i] = |diff[i*8+7:i*8];
            assign A[i] = |{&{iA[i+7], diff[i+7]},
                            &{iA[i+6],~diff[i+7],  diff[i+6]},
                            &{iA[i+5],~diff[i+7:i+6],diff[i+5]},
                            &{iA[i+4],~diff[i+7:i+5],diff[i+4]},
                            &{iA[i+3],~diff[i+7:i+4],diff[i+3]},
                            &{iA[i+2],~diff[i+7:i+3],diff[i+2]},
                            &{iA[i+1],~diff[i+7:i+2],diff[i+1]},
                            &{iA[i],  ~diff[i+7:i+1],diff[i]}};
        end
    endgenerate
    generate
        for (i=0; i<OPERATOR_WIDTH/8/8; i=i+1) begin
            assign L2[i] = |L1[i*8+7:i*8];
        end
    endgenerate
    //////////////////////////////////////////////// 
    assign L1_buff = (L2[7]==1) ? L1[63:56] :
                     (L2[6]==1) ? L1[55:48] :
                     (L2[5]==1) ? L1[47:40] :
                     (L2[4]==1) ? L1[39:32] :
                     (L2[3]==1) ? L1[31:24] :
                     (L2[2]==1) ? L1[23:16] :
                     (L2[1]==1) ? L1[15:8] : L1[7:0];
//    wire A_1 = (diff_buff_2[7] == 1) ? A_sub[7] :
//               (diff_buff_2[6] == 1) ? A_sub[6] : 
//               (diff_buff_2[5] == 1) ? A_sub[5] : 
//               (diff_buff_2[4] == 1) ? A_sub[4] : 
//               (diff_buff_2[3] == 1) ? A_sub[3] : 
//               (diff_buff_2[2] == 1) ? A_sub[2] : 
//               (diff_buff_2[1] == 1) ? A_sub[1] : A_sub[0]; // -0.221
    wire A_1 = |{&{A_sub[7],diff_buff_2[7]},
                 &{A_sub[6],~diff_buff_2[7],diff_buff_2[6]},
                 &{A_sub[5],~diff_buff_2[7:6],diff_buff_2[5]},
                 &{A_sub[4],~diff_buff_2[7:5],diff_buff_2[4]},
                 &{A_sub[3],~diff_buff_2[7:4],diff_buff_2[3]},
                 &{A_sub[2],~diff_buff_2[7:3],diff_buff_2[2]},
                 &{A_sub[1],~diff_buff_2[7:2],diff_buff_2[1]},
                 &{A_sub[0],~diff_buff_2[7:1],diff_buff_2[0]}};
    assign oRes = {A_1&{|L2},|L2,~A_1&{|L2}};
endmodule

//module comparator_512bit#(parameter OPERATOR_WIDTH = 512)(
//    input  wire [OPERATOR_WIDTH-1:0] diff,iA,
//    output wire [2:0] oRes
//);
//    wire [OPERATOR_WIDTH/8-1:0] L1;
//    wire [OPERATOR_WIDTH/8/8-1:0] L2;
//    genvar i;
//    generate
//        for (i=0; i<OPERATOR_WIDTH/8; i=i+1) begin
//            assign L1[i] = |diff[i*8+7:i*8];
//        end
//    endgenerate
//    generate
//        for (i=0; i<OPERATOR_WIDTH/8/8; i=i+1) begin
//            assign L2[i] = |L1[i*8+7:i*8];
//        end
//    endgenerate
//    //////////////////////////////////////////////// 
//    reg A_1;
//    reg [2:0] rRes;
//    reg [3:0] L2_4, L1_4, A_4, d_4;
//    reg [1:0] L2_2, L1_2, A_2, d_2;
//    reg [31:0] L1_32, A_32, d_32;
//    reg [15:0] L1_16, A_16, d_16;
//    reg [7:0]  L1_8, A_8, d_8;
//    reg [255:0] A_256, d_256;
//    reg [127:0] A_128, d_128;
//    reg [63:0] A_64, d_64;
//    always @(*) begin
//             if (|L2[7:4] == 1)   begin L2_4 = L2[7:4]; L1_32 = L1[63:32]; A_256 = iA[511:256]; d_256 = diff[511:256]; end
//        else                      begin L2_4 = L2[3:0]; L1_32 = L1[31:0];  A_256 = iA[255:0];   d_256 = diff[255:0];   end
//             if (|L2_4[3:2] == 1) begin L2_2 = L2_4[3:2]; L1_16 = L1[31:16]; A_128 = A_256[255:128]; d_128 = d_256[255:128]; end
//        else                      begin L2_2 = L2_4[1:0]; L1_16 = L1[15:0];  A_128 = A_256[127:0];   d_128 = d_256[127:0];   end
//             if (|L2_2[1] == 1)   begin L1_8 = L1[15:8]; A_64 = A_128[127:64]; d_64 = d_128[127:64]; end
//        else                      begin L1_8 = L1[7:0];  A_64 = A_128[63:0];   d_64 = d_128[63:0];   end
 
//             if (|L1_8[7:4] == 1) begin L1_4 = L1_8[7:4];   A_32 = A_64[63:32]; d_32 = d_64[63:32];  end
//        else                      begin L1_4 = L1_8[3:0];   A_32 = A_64[31:0];  d_32 = d_64[31:0];   end
//             if (|L1_4[3:2] == 1) begin L1_2 = L1_4[3:2]; A_16 = A_32[31:16]; d_16 = d_32[31:16];  end
//        else                      begin L1_2 = L1_4[1:0]; A_16 = A_32[15:0];  d_16 = d_32[15:0];   end
//             if (|L1_2[1] == 1)   begin A_8 = A_16[15:8]; d_8 = d_16[15:8]; end
//        else                      begin A_8 = A_16[7:0];  d_8 = d_16[7:0];  end
        
//             if (|d_8[7:4] == 1) begin A_4 = A_8[7:3]; d_4 = d_8[7:3];  end
//        else                     begin A_4 = A_8[4:0]; d_4 = d_8[4:0];  end
//             if (|d_4[3:2] == 1) begin A_2 = A_4[3:2]; d_2 = d_4[3:2];  end
//        else                     begin A_2 = A_4[1:0]; d_2 = d_4[1:0];  end
//             if (|d_2[1] == 1)   begin A_1 = A_2[1]; end
//        else                     begin A_1 = A_2[0]; end
        
//             if (|L2 == 0) rRes = 3'b010 ;
//        else if (A_1 == 1) rRes = 3'b100 ;
//        else if (A_1 == 0) rRes = 3'b001 ;
//        else               rRes = 3'b000 ;
//    end
//    assign oRes = rRes;
//endmodule

module comparator_512bit#(parameter OPERATOR_WIDTH = 512)(
    input  wire [OPERATOR_WIDTH-1:0] diff,iA,
    output wire [2:0] oRes
);
    wire [OPERATOR_WIDTH/8-1:0] L1,A;
    wire [OPERATOR_WIDTH/8/8-1:0] L2, L1_buff, A_sub, diff_buff_2;
    genvar i;
    generate
        for (i=0; i<OPERATOR_WIDTH/8; i=i+1) begin
            assign L1[i] = |diff[i*8+7:i*8];
            assign  A[i] = |{&{iA[8*i+7], diff[8*i+7]},
                             &{iA[8*i+6],~diff[8*i+7],    diff[8*i+6]},
                             &{iA[8*i+5],~diff[8*i+7:8*i+6],diff[8*i+5]},
                             &{iA[8*i+4],~diff[8*i+7:8*i+5],diff[8*i+4]},
                             &{iA[8*i+3],~diff[8*i+7:8*i+4],diff[8*i+3]},
                             &{iA[8*i+2],~diff[8*i+7:8*i+3],diff[8*i+2]},
                             &{iA[8*i+1],~diff[8*i+7:8*i+2],diff[8*i+1]},
                             &{iA[8*i],  ~diff[8*i+7:8*i+1],diff[8*i]}}; 
        end
    endgenerate
    generate
        for (i=0; i<OPERATOR_WIDTH/8/8; i=i+1) begin
            assign L2[i] = |L1[i*8+7:i*8];
        end
    endgenerate
    //////////////////////////////////////////////// 
    assign L1_buff = (L2[7]==1) ? L1[63:56] :
                     (L2[6]==1) ? L1[55:48] :
                     (L2[5]==1) ? L1[47:40] :
                     (L2[4]==1) ? L1[39:32] :
                     (L2[3]==1) ? L1[31:24] :
                     (L2[2]==1) ? L1[23:16] :
                     (L2[1]==1) ? L1[15:8] : L1[7:0];
    wire[7:0] A_8  = (L2[7]==1) ? A[63:56] :    
                      (L2[6]==1) ? A[55:48] :    
                      (L2[5]==1) ? A[47:40] :    
                      (L2[4]==1) ? A[39:32] :    
                      (L2[3]==1) ? A[31:24] :    
                      (L2[2]==1) ? A[23:16] :    
                      (L2[1]==1) ? A[15:8]  : A[7:0];
    wire A_1 = (L1_buff[7]==1)  ? A_8[7] :         
                (L1_buff[6]==1) ? A_8[6] :        
                (L1_buff[5]==1) ? A_8[5] :        
                (L1_buff[4]==1) ? A_8[4] :        
                (L1_buff[3]==1) ? A_8[3] :        
                (L1_buff[2]==1) ? A_8[2] :        
                (L1_buff[1]==1) ? A_8[1]  : A_8[0];
    assign oRes = {A_1&{|L2},~(|L2),~A_1&{|L2}};
endmodule