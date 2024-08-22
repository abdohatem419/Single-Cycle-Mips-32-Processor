//===========================================================
// Project:     MIPS 32 Single-Cycle Processor
// File:        main_decoder.v
// Author:      Abdelrahman Hatem Nasr
// Date:        2024-08-22
// Description: Main Decoder module for MIPS 32. This module
//              decodes the opcode of the instruction to generate
//              control signals for various operations in the CPU.
//              It sets the control signals based on the type of
//              instruction (R-type, LW, SW, BEQ, ADI, J) and
//              defaults to zero if the opcode is not recognized.
//===========================================================

module main_decoder(Op, MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, ALUOp, Jump);

//===========================================================
// Port Declarations
//===========================================================
input [5:0] Op;            // 6-bit opcode input from instruction
output reg MemtoReg;       // Control signal for MemtoReg
output reg MemWrite;       // Control signal for memory write
output reg Branch;         // Control signal for branch
output reg ALUSrc;         // Control signal for ALU source
output reg RegDst;         // Control signal for register destination
output reg RegWrite;       // Control signal for register write
output reg Jump;          // Control signal for jump
output reg [1:0] ALUOp;   // 2-bit ALU operation code

//===========================================================
// Control Signal Generation
//===========================================================
always @(*) begin
    // Default control signals
    RegWrite = 1'b0;
    RegDst   = 1'b0;
    ALUSrc   = 1'b0;
    Branch   = 1'b0;
    MemWrite = 1'b0;
    MemtoReg = 1'b0;
    ALUOp    = 2'b00;
    Jump     = 1'b0;

    // Set control signals based on opcode
    case(Op)
    6'b000000: begin // R-type instructions
        RegWrite = 1'b1;
        RegDst   = 1'b1;
        ALUOp    = 2'b10;
    end
    6'b100011: begin // LW (Load Word)
        RegWrite = 1'b1;
        ALUSrc   = 1'b1;
        MemtoReg = 1'b1;
    end
    6'b101011: begin // SW (Store Word)
        ALUSrc   = 1'b1;
        MemWrite = 1'b1;
    end
    6'b000100: begin // BEQ (Branch on Equal)
        Branch   = 1'b1;
        ALUOp    = 2'b01;
    end
    6'b001000: begin // ADDI (Add Immediate)
        RegWrite = 1'b1;
        ALUSrc   = 1'b1;
    end
    6'b000010: begin // J (Jump)
        Jump     = 1'b1;
    end
    default: begin
        // Default values if opcode is not recognized
        RegWrite = 1'b0;
        RegDst   = 1'b0;
        ALUSrc   = 1'b0;
        Branch   = 1'b0;
        MemWrite = 1'b0;
        MemtoReg = 1'b0;
        ALUOp    = 2'b00;
        Jump     = 1'b0;
    end
    endcase
end

endmodule
