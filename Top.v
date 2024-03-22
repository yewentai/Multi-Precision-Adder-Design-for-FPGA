`timescale 1ns / 1ps

module Top (
    input  wire iClk,
    input  wire iRst,
    input  wire iRx,
    output wire oTx);

wire o_Switch;

Debounce_Switch Debounce(
    .i_Clk(iClk),
    .i_Switch(iRst),
    .o_Switch(o_Switch)
);

uart_top uart(
    .iClk(iClk),
    .iRst(o_Switch),
    .iRx(iRx),
    .oTx(oTx)
);


endmodule