`define WIDTH 4
module adder(
	a,
	b,
	result
);

input[`WIDTH-1:0] a,b;
output[`WIDTH-1:0] result;

assign result = a + b;

endmodule



