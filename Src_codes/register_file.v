module register_file(clk,rst_n,A1,A2,A3,WD3,WE3,RD1,RD2);

input WE3,clk,rst_n;
input [31:0] WD3;
input [4:0] A1,A2,A3;
output reg [31:0] RD1,RD2;
reg [31:0] reg_file [31:0];

integer i;
always@(posedge clk or negedge rst_n)begin
   if(!rst_n)begin
        for(i = 0 ; i < 32 ; i = i+1) begin
            reg_file[i] <= 0;
        end
   end
   else begin
        if(WE3)begin
            reg_file [A3] <= WD3;
        end
        RD1 <= reg_file [A1];
        RD2 <= reg_file [A2];
   end
end
endmodule