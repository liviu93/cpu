
module addr_adder(
	base,
	offset,
	result
);

input[3:0] base;
wire[3:0] base;

input[1:0] offset;
wire[1:0] offset;

output[3:0] result;


wire[3:0] real_offset = offset;

assign result = base + real_offset;






endmodule
