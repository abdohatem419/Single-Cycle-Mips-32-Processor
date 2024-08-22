//===========================================================
// Project:     MIPS 32 Single-Cycle Processor
// File:        instruction_memory.v
// Author:      Abdelrahman Hatem Nasr
// Date:        2024-08-22
// Description: Instruction Memory module for MIPS 32. This
//              module implements a simple read-only memory
//              array that stores instructions. The memory is
//              accessed based on the address input, with the
//              address being shifted right by 2 to account for
//              word alignment (assuming instructions are 32 bits
//              wide and the address is byte-aligned).
//===========================================================

module instruction_memory(A, RD);

//===========================================================
// Port Declarations
//===========================================================
input [31:0] A;         // 32-bit address input for instruction fetch
output [31:0] RD;       // 32-bit read data output (instruction)

//===========================================================
// Internal Memory Declaration
//===========================================================
// Memory array with 100 words, each 32 bits wide
reg [31:0] instr_mem [99:0];

//===========================================================
// Read Operation (Combinational)
//===========================================================
// Read instruction from memory based on the address input
// Address is shifted right by 2 to align with word boundaries
assign RD = instr_mem[A >> 2];

endmodule
