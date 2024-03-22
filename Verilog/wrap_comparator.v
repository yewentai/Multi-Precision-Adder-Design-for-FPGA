module wrap_comparator#(parameter OPERATOR_WIDTH = 64)(
    input  wire iClk, iRst,
    output wire oXORResult
  );
    // 1. Create a counter to feed registered inputs to the adder
  // --------------------------------------------------------------
  // The number of bits of the counter should be : 
  //    length(OperandA) + lenght(OperandB) + length(CarryIn)
      
  // Describe the counter
  //  -> when the variable rCnt is full (all ones), it will wrap back to zero
  reg [2*OPERATOR_WIDTH-1:0]  rCnt;  
      
  always @(posedge iClk)
    if (iRst==1)
      rCnt <= 0;
    else
      rCnt <= rCnt+1;
      
  // 2. Instantiate the combinational adder
  // --------------------------------------------------------------
  // The inputs from the adder are taken from the Counter register
  //  -> the upper OPERATOR_WIDTH bits are Input A
  //  -> the next OPERATOR_WIDTH bits are Input B
  //  -> the last bit is the Carry Input
      
  wire [2:0] wResult;
      
  comparator_512bit  UUT   (
    .iA( rCnt[2*OPERATOR_WIDTH-1:OPERATOR_WIDTH] ), 
    .iB( rCnt[OPERATOR_WIDTH-1:0] ),
    .oRes(wResult)
  );
        
  // 3. Add a register at the outputs
  // ------------------------------------
  // Needed to obtain timing measurements in register-to-register paths
  reg [2:0] rResult;
      
  always @(posedge iClk)
  begin
    rResult <= wResult;
  end
      
  // 4. XOR all bits in wResult and give them as single output
  //-------------------------------------
  // 'Hack' to prevent Vivado from optimizing away the adder
  assign oXORResult = ^rResult;
  
endmodule