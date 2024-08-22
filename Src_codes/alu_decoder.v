//===========================================================
// Project:     MIPS 32 Single-Cycle Processor
// File:        alu_decoder.v
// Author:      Abdelrahman Hatem Nasr
// Date:        2024-08-22
// Description: ALU Decoder module for MIPS 32. Based on the
//              ALUOp and Funct inputs, it outputs a 3-bit
//              ALUControl signal that dictates the operation
//              the ALU performs, such as addition, subtraction,
//              AND, OR, and set-less-than comparison.
//===========================================================

module alu_decoder(Funct, ALUOp, ALUControl);

//===========================================================
// Port Declarations
//===========================================================
input  [5:0] Funct;          // 6-bit function code from the instruction
input  [1:0] ALUOp;          // 2-bit ALUOp signal from the control unit
output reg [2:0] ALUControl; // 3-bit output control signal to ALU

//===========================================================
// Main Functionality
//===========================================================
// Based on the ALUOp and Funct, determine the ALU operation
always @(*) begin
    case (ALUOp)
        // Load/Store operations, ALU performs addition
        2'b00: begin
            ALUControl = 3'b010;  // Addition operation
        end
        // Branch operation, ALU performs subtraction
        2'b01: begin
            ALUControl = 3'b110;  // Subtraction operation
        end
        // R-type instructions
        2'b10: begin
            case (Funct)
                6'b100000: ALUControl = 3'b010;  // ADD operation
                6'b100010: ALUControl = 3'b110;  // SUB operation
                6'b100100: ALUControl = 3'b000;  // AND operation
                6'b100101: ALUControl = 3'b001;  // OR operation
                6'b101010: ALUControl = 3'b111;  // SLT operation (set on less than)
            endcase
        end
    endcase
end

endmodule
