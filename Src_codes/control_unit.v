//===========================================================
// Project:     MIPS 32 Single-Cycle Processor
// File:        control_unit.v
// Author:      Abdelrahman Hatem Nasr
// Date:        2024-08-22
// Description: Control Unit module for MIPS 32. It generates
//              control signals for memory operations, branch
//              decisions, and ALU operations based on the 
//              instruction opcode (Op) and function code (Funct).
//===========================================================

module control_unit (Op, Funct, MemtoReg, MemWrite, Branch, ALUControl, ALUSrc, RegDst, RegWrite, Jump);

//===========================================================
// Port Declarations
//===========================================================
input  [5:0] Op;        // 6-bit opcode from the instruction
input  [5:0] Funct;     // 6-bit function code for R-type instructions
output MemtoReg;        // Control signal to select between ALU result and memory data
output MemWrite;        // Control signal to enable memory write
output Branch;         // Control signal to enable branching
output ALUSrc;         // Control signal to select between register and immediate for ALU
output RegDst;         // Control signal to select destination register
output RegWrite;       // Control signal to enable register write
output Jump;          // Control signal to enable jump operations
output [2:0] ALUControl; // 3-bit control signal for ALU operation

// Internal wire for ALU operation codes
wire [1:0] ALUOp;     // 2-bit ALU operation code for ALU decoding

//===========================================================
// Module Instantiations
//===========================================================
// Instantiate the main decoder to generate control signals based on the opcode
main_decoder m_dec (
    .Op(Op),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .Branch(Branch),
    .ALUSrc(ALUSrc),
    .RegDst(RegDst),
    .RegWrite(RegWrite),
    .ALUOp(ALUOp),
    .Jump(Jump)
);

// Instantiate the ALU decoder to generate ALU control signals based on the function code
alu_decoder a_dec (
    .Funct(Funct),
    .ALUOp(ALUOp),
    .ALUControl(ALUControl)
);

endmodule
