module instruction_memory(A,RD);

input [31:0] A;
output [31:0] RD;
reg [31:0] instr_mem [99:0];

assign RD = instr_mem[A>>2];

endmodule