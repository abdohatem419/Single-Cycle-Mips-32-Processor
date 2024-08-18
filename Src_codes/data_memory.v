module data_memory(clk,rst_n,WE,A,RD,WD);

input clk,WE;
input [31:0] A,WD;
output reg [31:0] RD;
reg [31:0] data_mem [99:0];

always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        RD <= 0;
    end
    else begin
        if (WE) begin
            data_mem [A] <= WD;
        end
        RD <= data_mem [A];
    end
end
endmodule