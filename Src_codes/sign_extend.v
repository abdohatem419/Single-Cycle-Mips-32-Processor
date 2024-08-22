//===========================================================
// Project:     MIPS 32 Single-Cycle Processor
// File:        sign_extend.v
// Author:      Abdelrahman Hatem Nasr
// Date:        2024-08-22
// Description: Sign extension module that extends a 16-bit input
//              to a 32-bit output by replicating the sign bit
//              of the input. The sign bit (most significant bit) 
//              of the 16-bit input is used to fill the upper 16 
//              bits of the output.
//===========================================================

module sign_extend(
    In,   // 16-bit input signal to be sign-extended
    Out   // 32-bit output signal after sign extension
);

//===========================================================
// Port Declarations
//===========================================================
input [15:0] In;      // 16-bit input signal
output reg [31:0] Out; // 32-bit output signal

//===========================================================
// Sign Extension Operation
//===========================================================
always @(*) begin
    if (In[15] == 1) begin
        Out <= {16'd1, In}; // Extend with 1s if sign bit is 1
    end
    else begin
        Out <= {16'd0, In}; // Extend with 0s if sign bit is 0
    end
end

endmodule
