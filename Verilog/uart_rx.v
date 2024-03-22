`timescale 1ns / 1ps

module uart_rx #(
  parameter   CLK_FREQ      = 125_000_000,
  parameter   BAUD_RATE     = 115_200,
  // Example: 125 MHz Clock / 115200 baud UART -> CLKS_PER_BIT = 1085 
  parameter   CLKS_PER_BIT  = CLK_FREQ / BAUD_RATE
)
(
  input wire        iClk, iRst,
  input wire        iRxSerial,
  output wire [7:0] oRxByte, 
  output wire       oRxDone
);

  // State definition  
  localparam sIDLE         = 3'b000;
  localparam sRX_START     = 3'b001;
  localparam sRX_DATA      = 3'b010;
  localparam sRX_STOP      = 3'b011;
  localparam sDONE         = 3'b100;
  
  // Register variables required to drive the FSM
  //---------------------------------------------
  // Remember:  -> 'current' is the register output
  //            -> 'next' is the register input
  
  // -> FSM state
  reg [2:0] rFSM_Current, wFSM_Next; 
  
  // -> counter to keep track of the clock cycles
  reg [$clog2(CLKS_PER_BIT):0]   rCnt_Current;
    
  // -> counter to keep track of sent bits
  // (between 0 and 7)
  reg [2:0] rBit_Current;
  
  // Double-register the input wire to prevent metastability issues
  reg rRx1, rRx2;
  
//  reg [7:0] data_reg;
  reg [7:0] rRxData_Current, wRxData_Next;  
  reg RxStart;

    always @(posedge iClk) begin
        if(iRst == 1) begin
            rFSM_Current <= sIDLE;
            rRxData_Current <= 0;
            rRx1 <= 0;
            rRx2 <= 0;
        end
        else begin
            rFSM_Current <= wFSM_Next;
            rRxData_Current <= wRxData_Next;
            rRx1 <= iRxSerial;
            rRx2 <= rRx1;
        end
    end
    
    always @(posedge iClk) begin
        if(iRst == 1)
            rCnt_Current <= 0;
        else if((rFSM_Current == sIDLE)||(rFSM_Current == sDONE))
            rCnt_Current <= 0;
        else if(((rFSM_Current == sRX_START)||(rFSM_Current == sRX_DATA)||(rFSM_Current == sRX_STOP))&&(rCnt_Current < (CLKS_PER_BIT - 1)))
            rCnt_Current <= rCnt_Current + 1;
        else
            rCnt_Current <= 0;
    end
    
    always @(posedge iClk) begin
        if(iRst == 1)
            rBit_Current <= 0;
        else if((rFSM_Current == sIDLE)||(rFSM_Current == sRX_START)||(rFSM_Current == sRX_STOP)||(rFSM_Current == sDONE))
            rBit_Current <= 0;
        else if((rFSM_Current == sRX_DATA)&&(rCnt_Current < (CLKS_PER_BIT - 1)))
            rBit_Current <= rBit_Current;
        else if((rFSM_Current == sRX_DATA)&&(rCnt_Current == (CLKS_PER_BIT - 1))&&(rBit_Current != 7))
            rBit_Current <= rBit_Current + 1;
        else
            rBit_Current <= 0;
    end
    
//    always @(posedge iClk) begin
//        if(iRst == 1)
//            data_reg <= 0;
//        else
//            case(rFSM_Current)
//                sIDLE:     data_reg <= data_reg;
//                sRX_START: data_reg <= data_reg;
//                sRX_DATA:
//                    if(rCnt_Current == ((CLKS_PER_BIT >> 1) - 1))
//                        case(rBit_Current)
//                            0: data_reg[0] <= rRx1;
//                            1: data_reg[1] <= rRx1;
//                            2: data_reg[2] <= rRx1;
//                            3: data_reg[3] <= rRx1;
//                            4: data_reg[4] <= rRx1;
//                            5: data_reg[5] <= rRx1;
//                            6: data_reg[6] <= rRx1;
//                            7: data_reg[7] <= rRx1;
//                            default: ;
//                        endcase
//                    else
//                        data_reg <= data_reg;
//                sRX_STOP:  data_reg <= data_reg;
//                sDONE:     data_reg <= data_reg;
//                default:   data_reg <= 0;
//            endcase
//        end
    always @(posedge iClk) begin
        if(iRst == 1)
            wRxData_Next <= 0;
        else
            case(rFSM_Current)
                sIDLE:     wRxData_Next <= rRxData_Current;
                sRX_START: wRxData_Next <= rRxData_Current;
                sRX_DATA:
                    if(rCnt_Current == ((CLKS_PER_BIT >> 1) - 2))
                        wRxData_Next <= {rRx1, rRxData_Current[7:1]};
                    else
                        wRxData_Next <= wRxData_Next;
//                sRX_STOP:  wRxData_Next <= rRxData_Current;
                sDONE:     wRxData_Next <= rRxData_Current;
                default:   wRxData_Next <= 0;
            endcase
    end
       
    always @(posedge iClk) begin
        if(iRst == 1)
            RxStart <= 0;
        else if((rFSM_Current == sIDLE)&&(rRx1 == 0)&&(rRx2 == 1))
            RxStart <= 1;
        else
            RxStart <= 0;    
    end
    
    always @(*) begin
        case(rFSM_Current)
            sIDLE:
                if(RxStart == 1)
                    wFSM_Next <= sRX_START;
                else
                    wFSM_Next <= sIDLE;
            sRX_START:
                if(rCnt_Current < (CLKS_PER_BIT - 1))
                    wFSM_Next <= sRX_START;
                else
                    wFSM_Next <= sRX_DATA;
            sRX_DATA:
                if(rCnt_Current < (CLKS_PER_BIT - 1))
                    wFSM_Next <= sRX_DATA;
                else if (rBit_Current != 7)
                    wFSM_Next <= sRX_DATA;
                else
                    wFSM_Next <= sDONE;
//            sRX_STOP:
//                if(rCnt_Current < (CLKS_PER_BIT - 1))
//                    wFSM_Next <= sRX_STOP;
//                else
//                    wFSM_Next <= sDONE;
            sDONE: wFSM_Next <= sIDLE;
            default: wFSM_Next <= sIDLE;
        endcase
    end
    
    reg [7:0] rRxSerial;
    always @(*) begin
        if (rFSM_Current == sRX_START)
          rRxSerial = 0;
        else if (rFSM_Current == sRX_DATA)
          rRxSerial = rRxData_Current;
        else
          rRxSerial = rRxData_Current;
    end
    
    assign oRxDone = (rFSM_Current == sDONE) ? 1 : 0;
//    assign oRxByte = data_reg;
    assign oRxByte = rRxSerial;
endmodule