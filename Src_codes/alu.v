module alu (SrcA,SrcB,ALUControl,Zero,ALUResult);

input [31:0] SrcA,SrcB;
input [2:0] ALUControl;
output  Zero;
output reg [31:0] ALUResult;

assign Zero = (ALUResult == 0)? 1'b1 : 1'b0;

always @(*) begin
    case (ALUControl)
    3'b000: begin
        ALUResult <= SrcA & SrcB;
    end
    3'b001: begin
        ALUResult <= SrcA | SrcB;
    end
    3'b010: begin
        ALUResult <= SrcA + SrcB;
    end
    3'b110: begin
        ALUResult <= SrcA - SrcB;
    end
    3'b111: begin
        if (SrcA < SrcB) begin
            ALUResult <= 'b1;
        end
        else begin
            ALUResult <= 'b0;
        end
    end
    default: begin
        ALUResult <= 'b0;
    end
    endcase
end
endmodule