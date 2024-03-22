module wrap_adder
  (
    input  wire   iClk, iRst,
    output wire   oXORResult, 
    output reg    oCarryOut
  );
      
  // 1. Create a counter to feed registered inputs to the adder
  // --------------------------------------------------------------
  // The number of bits of the counter should be : 
  //    length(OperandA) + lenght(OperandB) + length(CarryIn)
      
  // Describe the counter
  //  -> when the variable rCnt is full (all ones), it will wrap back to zero
  reg [2:0]  rCnt;  
      
  always @(posedge iClk)
    if (iRst==1)
      rCnt <= 0;
    else
      rCnt <= rCnt+1;
      
  // 2. Instantiate the combinational adder
  // --------------------------------------------------------------
  // The inputs from the adder are taken from the Counter register
  //  -> the upper ADDER_WIDTH bits are Input A
  //  -> the next ADDER_WIDTH bits are Input B
  //  -> the last bit is the Carry Input
      
  wire wResult;
  wire wCarryOut;
      
  adder_1bit  UUT   (
    .iA( rCnt[2] ), 
    .iB( rCnt[1] ),
    .iC( rCnt[0] ),
    .oSum(wResult),
    .oC(wCarryOut)
  );
        
  // 3. Add a register at the outputs
  // ------------------------------------
  // Needed to obtain timing measurements in register-to-register paths
  reg rResult;
      
  always @(posedge iClk)
  begin
    rResult <= wResult;
    oCarryOut <= wCarryOut;
  end
      
  // 4. XOR all bits in wResult and give them as single output
  //-------------------------------------
  // 'Hack' to prevent Vivado from optimizing away the adder
  assign oXORResult = ^rResult;
      
endmodule