`timescale 1ns / 1ps

module uart_top #(
    // values for the UART (in case we want to change them)
    parameter   CLK_FREQ      = 125_000_000,
    parameter   BAUD_RATE     = 115_200,
    parameter   OPERAND_WIDTH = 512,
    parameter   ADDER_WIDTH   = 128,
    parameter   NBYTES        = OPERAND_WIDTH/8
  )  
  (
    input   wire   iClk, iRst,
    input   wire   iRx,
    output  wire   oTx
  );
  
  // Buffer to exchange data between Pynq-Z2 and laptop
  
  reg [OPERAND_WIDTH-1:0] rBufferA, rBufferB, rA, rB;
  reg [7:0]               rBufferCmd;
  // State definition  
  localparam s_IDLE         = 3'b000;
  localparam s_RX_CMD       = 3'b001;
  localparam s_RX_OP        = 3'b010;
  localparam s_Calc         = 3'b011;
  localparam s_TX           = 3'b100;
  localparam s_WAIT_TX      = 3'b101;
  localparam s_DONE         = 3'b110;
   
  // Declare all variables needed for the finite state machine 
  // -> the FSM state
  reg [2:0]   rFSM;  
  
  // Connection to UART TX (inputs = registers, outputs = wires)
  reg         rTxStart;
  reg [7:0]   rTxByte, rRxByte;
  
  wire        wTxBusy;
  wire        wTxDone;
  wire        wRxDone;
  wire[7:0]   wRxByte;
      
  uart_tx #(  .CLK_FREQ(CLK_FREQ), .BAUD_RATE(BAUD_RATE) )
  UART_TX_INST
    (.iClk(iClk),
     .iRst(iRst),
     .iTxStart(rTxStart),
     .iTxByte(rTxByte),
     .oTxSerial(oTx),
     .oTxBusy(wTxBusy),
     .oTxDone(wTxDone)
     );
     
  uart_rx #(  .CLK_FREQ(CLK_FREQ), .BAUD_RATE(BAUD_RATE) )
  UART_RX_INST
    (.iClk(iClk),
     .iRst(iRst),
     .iRxSerial(iRx),
     .oRxByte(wRxByte),
     .oRxDone(wRxDone)
     );
  
  reg rStart;
  reg [(NBYTES+1)*8-1:0] rBuffer;
  wire wDone;
  wire [OPERAND_WIDTH:0]  wRes;
  wire [1:0] wSel;
  reg  [1:0] rSel;
  cmd_sel cmd_sel_INST(.iCmd(rBufferCmd),.oSel(wSel));
  Calculator_512bit #( .OPERAND_WIDTH(OPERAND_WIDTH), .ADDER_WIDTH(ADDER_WIDTH) )
  Calculator_512bit_INST
  ( .iClk(iClk), .iRst(iRst), .iStart(rStart),.iSel(rSel), .iOpA(rA), .iOpB(rB), .oRes(wRes), .oDone(wDone) );
//  wSel = 2'b01 ://adder     
//  wSel = 2'b11 ://substracto
//  wSel = 2'b10 ://comparator
  reg [$clog2(NBYTES)+1:0] rCnt;
  
  always @(posedge iClk)
  begin
  
  // reset all registers upon reset
  if (iRst == 1 ) 
    begin
      rFSM <= s_IDLE;
      rTxStart <= 0;
      rCnt <= 0;
      rTxByte <= 0;
      rBufferA <= 0;
      rBufferB <= 0;
    end 
  else 
    begin
      case (rFSM)
   
        s_IDLE :
          begin
            rFSM <= s_RX_CMD;
          end
        s_RX_CMD :
          begin
            if ( rCnt < 1 ) begin
              rFSM = s_RX_CMD; 
              if(wRxDone == 1) begin
                    rBufferCmd <= wRxByte;
                    rCnt <= rCnt + 1;
                end
                else begin
                    rCnt <= rCnt;
                    rBufferCmd <= rBufferCmd;
                end
            end
            else begin
                if ( wSel == 2'b00 ) begin // not receiving cmd
                    rFSM = s_RX_CMD;
                    rCnt <= 0;
                    rBufferCmd <= 0;
                end
                else begin
                    rFSM <= s_RX_OP;
                    rTxStart <= 0;
                    rTxByte <= 0;
                    rCnt <= 0;
                end
            end      
          end
        s_RX_OP :
          begin
            if ( rCnt < NBYTES ) begin
              rFSM = s_RX_OP; 
              if(wRxDone == 1) begin
                    rBufferA <= {rBufferA[NBYTES*8-9:0] , wRxByte};
                    rCnt <= rCnt + 1;
                end
                else begin
                    rCnt <= rCnt;
                    rBufferA <= rBufferA;
                end
              end
            else if( rCnt < 2*NBYTES ) begin
              rFSM = s_RX_OP; 
              if(wRxDone == 1) begin
                    rBufferB <= {rBufferB[NBYTES*8-9:0] , wRxByte};
                    rCnt <= rCnt + 1;
                end
                else begin
                    rCnt <= rCnt;
                    rBufferB <= rBufferB;
                end
            end
            else begin
                rFSM <= s_Calc;
                rTxStart <= 0;
                rTxByte <= 0;
                rCnt <= 0;
              end      
          end

        s_Calc :
        begin
            if ( wDone == 1 ) begin
                if (rBufferCmd == "C")
                    rBuffer <= {wRes, 7'b0000000};
                else
                    rBuffer <= {7'b0000000, wRes};
                rCnt <= 0;
                rFSM <= s_TX;
            end
            else begin
                if ( rCnt == 0 ) begin
                    rStart = 1;
                    rA <= rBufferA;
                    rB <= rBufferB;
                    rSel <= wSel;
                end
                else begin
                    rStart = 0;
                end
                rCnt <= rCnt + 1;
                rFSM <= s_Calc;
            end
        end
        
        s_TX :
          begin
            if ( (rCnt < NBYTES+1) && (wTxBusy ==0) ) 
              begin
                rFSM <= s_WAIT_TX;
                rTxStart <= 1;
                rTxByte <= rBuffer[(NBYTES+1)*8-1:NBYTES*8];            // we send the uppermost byte
                rBuffer <= {rBuffer[NBYTES*8-1:0] , 8'b0000_0000};    // we shift from right to left
                rCnt <= rCnt + 1;
              end 
            else 
              begin
                rFSM <= s_DONE;
                rTxStart <= 0;
                rTxByte <= 0;
                rCnt <= 0;
              end
            end 
            
            s_WAIT_TX :
              begin
                if (wTxDone) begin
                  rFSM <= s_TX;
                end else begin
                  rFSM <= s_WAIT_TX;
                  rTxStart <= 0;                   
                end
              end 
              
            s_DONE :
              begin
                rFSM <= s_IDLE;
              end 

            default :
              rFSM <= s_IDLE;
             
          endcase
      end
    end       
    
endmodule