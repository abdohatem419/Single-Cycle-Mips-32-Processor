//===========================================================
// Project:     MIPS 32 Single-Cycle Processor
// File:        alu.v
// Author:      Abdelrahman Hatem Nasr
// Date:        2024-08-22
// Description: ALU module for MIPS 32 processor. This ALU
//              performs arithmetic and logical operations
//              based on ALUControl input. Operations include 
//              AND, OR, addition, subtraction, and comparison.
//===========================================================

module alu (SrcA, SrcB, ALUControl, Zero, ALUResult);

//===========================================================
// Port Declarations
//===========================================================
input  [31:0] SrcA, SrcB;     // 32-bit ALU input operands
input  [2:0]  ALUControl;     // Control signal to select operation
output        Zero;           // Output flag for zero result
output reg [31:0] ALUResult;  // 32-bit ALU result output

//===========================================================
// Internal Signal Declarations
//===========================================================
// The Zero flag is set to 1 when ALUResult equals zero, otherwise it is 0
assign Zero = (ALUResult == 0) ? 1'b1 : 1'b0;

//===========================================================
// ALU Operation
//===========================================================
// Based on the ALUControl input, the ALU performs different operations
always @(*) begin
    case (ALUControl)
        3'b000: begin
            ALUResult = SrcA & SrcB;  // AND operation
        end
        3'b001: begin
            ALUResult = SrcA | SrcB;  // OR operation
        end
        3'b010: begin
            ALUResult = SrcA + SrcB;  // Addition
        end
        3'b110: begin
            ALUResult = SrcA - SrcB;  // Subtraction
        end
        3'b111: begin
            // Set-less-than comparison
            // ALUResult is set to 1 if SrcA < SrcB, else 0
            if (SrcA < SrcB) begin
                ALUResult = 32'b1;
            end
            else begin
                ALUResult = 32'b0;
            end
        end
        default: begin
            ALUResult = 32'b0;  // Default case: result is 0
        end
    endcase
end

endmodule
