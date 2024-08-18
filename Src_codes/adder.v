module adder (Operand_1,Operand_2,Result);

input [31:0] Operand_1,Operand_2;
output [31:0] Result;

assign Result = Operand_1 + Operand_2;
endmodule