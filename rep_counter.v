`define W 2
module rep_counter (
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



counter rc (
	.out(out),
	.data(data),
	.load(load),
	.enable(enable),
	.clk(clk),
	.reset(reset)
);

defparam rc.WIDTH = `W;

endmodule


