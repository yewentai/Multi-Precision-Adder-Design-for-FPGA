/////////////////////WNS = 0.906ns////////////////
module adder_1bit(
    input  wire iA, iB,
    input  wire iC,
    output wire oSum,
    output wire G,
    output wire P,
    output wire oC
);

    wire AB = iA & iB;
    wire A_B = iA | iB;
    wire AxB = AB | ~A_B;//NXOR
    wire nAxB = ~AxB;//XOR
    //wire C1 = AB;//C==1
    //wire C0 = AB | A_B;//C==0
    
    //assign oC =   (iC == 1) ? C1 : C0;//WNS = 0.906ns
    assign oC = AB | A_B & iC;
    assign oSum = (iC == 1) ? AxB : nAxB;
    assign G = AB;
    assign P = nAxB;
endmodule


/////////////////!!!Timing Failed!!!////////////////
//module adder_1bit(
//    input  wire iA, iB,
//    input  wire iC,
//    output wire oSum,
//    output wire G,
//    output wire P,
//    output wire oC
//);

//    wire AB = iA & iB;
//    wire A_B = iA | iB;
//    wire AxB = iA ~^ iB;//NXOR
//    wire nAxB = iA ^ iB;//XOR
//    wire C1 = AB;//C==1
//    wire C0 = AB | A_B;//C==0
    
//    assign G = AB;
//    assign P = nAxB;
//    assign oC   = (iC == 1) ? C1 : C0;//AB | A_B & iC;
//    assign oSum = (iC == 1) ? AxB : nAxB;
//endmodule


