module sign_extend(In,Out);

input [15:0] In;
output reg [31:0] Out;

always@(*) begin
    if(In[14]==1) begin
        Out <= {1111111111111111,In};
    end
    else begin
        Out <= {0000000000000000,In};
    end
end
endmodule