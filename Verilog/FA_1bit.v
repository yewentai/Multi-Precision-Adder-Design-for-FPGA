module FA_1bit(
    input  wire iA, iB,
    input  wire iC,
    output wire oSum,
    output wire G,P,
    output wire oC
);
    xor(oSum,iA,iB,iC);
    or(oC,iA&iB,iA&iC,iB&iC);
    and(G,iA,iB);
    xor(P,iA,iB);
endmodule