//===========================================================
// Project:     MIPS 32 Single-Cycle Processor
// File:        mux_2_1.v
// Author:      Abdelrahman Hatem Nasr
// Date:        2024-08-22
// Description: 2-to-1 Multiplexer module with parameterized
//              width. This module selects between two input
//              values (I0 and I1) based on the selection signal
//              (Sel) and outputs the selected value.
//===========================================================

module mux_2_1(I0, I1, Sel, Out);

//===========================================================
// Parameter Declarations
//===========================================================
parameter WIDTH = 32;       // Width of the data bus, default is 32 bits

//===========================================================
// Port Declarations
//===========================================================
input [WIDTH-1:0] I0;      // First input data bus
input [WIDTH-1:0] I1;      // Second input data bus
input Sel;                // Selection signal (0 or 1)
output [WIDTH-1:0] Out;   // Output data bus

//===========================================================
// Multiplexer Logic
//===========================================================
assign Out = (Sel == 0) ? I0 : I1;  // Output is I0 if Sel is 0, otherwise I1

endmodule
