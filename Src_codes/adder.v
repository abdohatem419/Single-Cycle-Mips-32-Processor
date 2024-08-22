//===========================================================
// Project:     MIPS 32 Single-Cycle Processor
// File:        adder.v
// Author:      Abdelrahman Hatem Nasr
// Date:        2024-08-22
// Description: 32-bit adder module for calculating PC+4 and 
//              branch target addresses. Takes two 32-bit inputs 
//              and outputs their sum.
//===========================================================

module adder (Operand_1, Operand_2, Result);

//===========================================================
// Port Declarations
//===========================================================
input  [31:0] Operand_1, Operand_2; // 32-bit operands
output [31:0] Result;               // 32-bit result

//===========================================================
// Main functionality
//===========================================================
// Adds the two input operands and assigns the sum to the result
assign Result = Operand_1 + Operand_2;

endmodule
