module PC (PC_pre,PC_post,clk,rst_n);

input [31:0] PC_pre;
output reg [31:0]PC_post;
input clk;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        PC_post <= 0;
    end
    else begin
        PC_post <= PC_pre;
    end
end
endmodule