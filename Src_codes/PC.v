//===========================================================
// Project:     MIPS 32 Single-Cycle Processor
// File:        PC.v
// Author:      Abdelrahman Hatem Nasr
// Date:        2024-08-22
// Description: Program Counter (PC) module that stores the
//              current address of the instruction to be executed.
//              The PC is updated on the positive edge of the clock
//              or reset to zero on a negative edge of the reset signal.
//===========================================================

module PC (PC_pre, PC_post, clk, rst_n);

//===========================================================
// Port Declarations
//===========================================================
input [31:0] PC_pre;    // Input address to be loaded into PC
output reg [31:0] PC_post; // Current value of the PC
input clk;             // Clock signal
input rst_n;           // Asynchronous active-low reset signal

//===========================================================
// PC Update Logic
//===========================================================
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        // Asynchronous reset: set PC_post to 0
        PC_post <= 0;
    end
    else begin
        // Update PC_post with PC_pre on the rising edge of the clock
        PC_post <= PC_pre;
    end
end

endmodule
