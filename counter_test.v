`timescale 1ns / 10 ps
`define W 4


module counter_test ();

wire[`W-1:0] out;
reg[`W-1:0] data;
reg load, enable, clk, reset;

program_counter ct (
	.out(out),
	.data(data),
	.load(load),
	.enable(enable),
	.clk(clk),
	.reset(reset)
);


initial 
begin
	reset = 1;
	enable = 0;
	clk = 0;
	#10; 
	enable = 0;
	reset = 0;
	load = 1;
	data = 4'b1010;
	#10;



end

always
	#5 clk = !clk;


initial 
begin
	$dumpfile("counter_test.vcd");
	$dumpvars(0, counter_test);
end

initial
	#100 $finish;

endmodule


