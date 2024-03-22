`timescale 1ns / 1ps

module cmd_sel (
    input  wire [7:0] iCmd, 
    output wire [1:0] oSel
    );
    assign oSel = (iCmd =="A") ? 2'b01 ://adder 
                  (iCmd =="S") ? 2'b11 ://substractor
                  (iCmd =="C") ? 2'b10 ://comparator
                                 2'b00 ;
endmodule