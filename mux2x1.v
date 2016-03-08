module mux2x1(
	a,
	b,
	out,
	sel
);

input a;
input b;
input sel;
output out;

assign out = (sel) ? a : b;


endmodule
