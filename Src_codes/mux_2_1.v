module mux_2_1(I0,I1,Sel,Out);

parameter WIDTH=32;
input [WIDTH-1:0] I0,I1;
output [WIDTH-1:0] Out;
input Sel;

assign Out = (Sel==0) ? I0 : I1;

endmodule