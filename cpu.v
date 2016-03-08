module cpu (
	clk,
	out,
	data,
	load,
	enable,
	reset
);

output out;
input  data;
input load;
input enable;
input clk;
input reset;

program_counter pp(
	.clk(clk),
	.out(out),
	.data(data),
	.load(load),
	.enable(enable),
	.reset(reset)
);



endmodule
