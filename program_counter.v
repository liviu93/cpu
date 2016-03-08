`define W 4
module program_counter(
	out,
	data,
	load,
	enable,
	clk,
	reset
);


output[`W-1:0] out;

input[`W-1:0] data;

input load, enable, clk, reset;


counter pc(	.out(out), 
			.data(data), 
			.load(load), 
			.enable(enable),
			.clk(clk),
			.reset(reset)
		);
defparam pc.WIDTH = `W;

endmodule
