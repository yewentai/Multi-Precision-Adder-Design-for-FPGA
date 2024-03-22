module mux_8_64(
    input  wire [511:0] iA,
    input  wire [63:0] iA_sub,
    input  wire [7:0] sel,
    input  wire [7:0] in1,in2,in3,in4,in5,in6,in7,in8,
    output wire [7:0] out,
    output wire [63:0] oA,
    input  wire [7:0] oA_sub
);
    assign out = (sel[7]==1) ? in1 :
                 (sel[6]==1) ? in2 :
                 (sel[5]==1) ? in3 :
                 (sel[4]==1) ? in4 :
                 (sel[3]==1) ? in5 :
                 (sel[2]==1) ? in6 :
                 (sel[1]==1) ? in7 :
                 (sel[0]==1) ? in8 : 8'd0;
    assign oA  = (sel[7]==1) ? iA[511:448] :
                 (sel[6]==1) ? iA[447:384] :
                 (sel[5]==1) ? iA[383:320] :
                 (sel[4]==1) ? iA[319:256] :
                 (sel[3]==1) ? iA[255:192] :
                 (sel[2]==1) ? iA[191:128] :
                 (sel[1]==1) ? iA[127:64] :
                 (sel[0]==1) ? iA[63:0] : 64'd0;
    assign oA_sub = (sel[7]==1) ? iA_sub[63:56] :
                    (sel[6]==1) ? iA_sub[55:48] :
                    (sel[5]==1) ? iA_sub[47:40] :
                    (sel[4]==1) ? iA_sub[39:32] :
                    (sel[3]==1) ? iA_sub[31:24] :
                    (sel[2]==1) ? iA_sub[23:16] :
                    (sel[1]==1) ? iA_sub[15:8] :
                    (sel[0]==1) ? iA_sub[7:0] : 8'd0;
endmodule