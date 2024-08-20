module shifter (In,Out);

parameter WIDTH = 32;
input [WIDTH-1:0] In;
output [WIDTH-1:0] Out;

assign Out = In<<2;

endmodule