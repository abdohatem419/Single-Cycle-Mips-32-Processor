//===========================================================
// Project:     MIPS 32 Single-Cycle Processor
// File:        data_memory.v
// Author:      Abdelrahman Hatem Nasr
// Date:        2024-08-22
// Description: Data Memory module for MIPS 32. This module
//              implements a simple memory array with read and
//              write capabilities. The memory is accessed based
//              on the address provided, with write operations
//              occurring on the rising edge of the clock if 
//              write enable is asserted. The read operation is
//              combinational and provides data based on the 
//              address input.
//===========================================================

module data_memory(clk, rst_n, WE, A, RD, WD);

//===========================================================
// Port Declarations
//===========================================================
input        clk;       // Clock signal for synchronous operations
input        WE;        // Write enable signal
input        rst_n;     // Active-low reset signal
input [31:0] A;         // 32-bit address input for memory access
input [31:0] WD;        // 32-bit write data input
output reg [31:0] RD;   // 32-bit read data output

//===========================================================
// Internal Memory Declaration
//===========================================================
// Memory array with 100 words, each 32 bits wide
reg [31:0] data_mem [99:0];

//===========================================================
// Read Operation (Combinational)
//===========================================================
// Read data from memory based on the address input
always @(*) begin
    RD = data_mem[A];
end

//===========================================================
// Write Operation (Synchronous)
//===========================================================
// On positive edge of the clock or negative edge of the reset
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        // Reset the read data to 0 on reset
        RD <= 0;
    end
    else begin
        if (WE) begin
            // Write data to memory at the address provided
            data_mem[A] <= WD;
        end
    end
end

endmodule
