module alu_decoder(Funct,ALUOp,ALUControl);

input [5:0] Funct;
input [1:0] ALUOp;
output reg [2:0] ALUControl;

always@(*) begin
    casex (ALUOp)
    2'b00: begin
        ALUControl <= 3'b010;
    end
    2'b01: begin
        ALUControl <= 3'b110;
    end
    2'b1x: begin
        if(Funct == 'b100000)begin
            ALUControl <= 3'b010;
        end
        else if(Funct == 'b100010)begin
            ALUControl <= 3'b110;
        end
        else if(Funct == 'b100100)begin
            ALUControl <= 3'b000;
        end
        else if(Funct == 'b100101)begin
            ALUControl <= 3'b001;
        end
        else if(Funct == 'b101010)begin
            ALUControl <= 3'b111;
        end
    end
    endcase
end
endmodule