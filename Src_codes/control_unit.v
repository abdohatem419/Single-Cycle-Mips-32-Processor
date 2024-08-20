module control_unit (Op,Funct,MemtoReg,MemWrite,Branch,ALUControl,ALUSrc,RegDst,RegWrite,Jump);

input [5:0] Op,Funct;
output MemtoReg,MemWrite,Branch,ALUSrc,RegDst,RegWrite,Jump;
output [2:0] ALUControl;
wire [1:0] ALUOp;

main_decoder m_dec (Op,MemtoReg,MemWrite,Branch,ALUSrc,RegDst,RegWrite,ALUOp,Jump);
alu_decoder a_dec (Funct,ALUOp,ALUControl);

endmodule