//===========================================================
// Project:     MIPS 32 Single-Cycle Processor
// File:        register_file.v
// Author:      Abdelrahman Hatem Nasr
// Date:        2024-08-22
// Description: Register File module for the MIPS processor.
//              It contains 32 registers, each 32 bits wide.
//              On a positive edge of the clock, the register file
//              updates the register specified by A3 with the value
//              from WD3 if WE3 is asserted. On reset, all registers
//              are initialized to zero. The read ports A1 and A2 
//              provide the values of the specified registers RD1 and RD2.
//===========================================================

module register_file(
    clk,          // Clock signal
    rst_n,        // Asynchronous active-low reset signal
    A1,           // Address of the first register to read
    A2,           // Address of the second register to read
    A3,           // Address of the register to write
    WD3,          // Data to be written into the register specified by A3
    WE3,          // Write enable signal for the register file
    RD1,          // Data read from the register specified by A1
    RD2           // Data read from the register specified by A2
);

//===========================================================
// Port Declarations
//===========================================================
input WE3;                // Write enable signal
input clk;                // Clock signal
input rst_n;              // Asynchronous active-low reset
input [31:0] WD3;        // Data to write into the register
input [4:0] A1, A2, A3;  // Register addresses
output reg [31:0] RD1, RD2; // Data read from registers

//===========================================================
// Register File Storage
//===========================================================
reg [31:0] reg_file [31:0]; // Array of 32 registers, each 32 bits wide

integer i; // Integer for loop indexing

//===========================================================
// Synchronous Reset and Write Logic
//===========================================================
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        // Asynchronous reset: initialize all registers to 0
        for (i = 0; i < 32; i = i + 1) begin
            reg_file[i] <= 0;
        end
    end
    else begin
        if (WE3) begin
            // Write data into the register specified by A3
            reg_file[A3] <= WD3;
        end
    end
end

//===========================================================
// Read Logic
//===========================================================
always @(*) begin
    // Read data from the registers specified by A1 and A2
    RD1 = reg_file[A1];
    RD2 = reg_file[A2];
end

endmodule
