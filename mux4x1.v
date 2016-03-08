module mux4x1(
	sel,
	in,
	out
);

input[1:0] sel;

input[3:0] in;
output out;

assign out = in[sel];


endmodule

