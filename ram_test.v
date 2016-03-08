`timescale 1 ns / 1ps

module ram_test();

reg clk;

reg[3:0] a_a;
reg[3:0] a_b;

reg[3:0] dest;
reg data;

wire o_a;
wire o_b;

ram r(
	.clk(clk),
	.address_a(a_a),
	.address_b(a_b),
	.dest(dest),
	.data(data),
	.out_a(o_a),
	.out_b(o_b)
);


initial 
begin
	clk = 0;
	#5;
	dest=1;
	data=1;
	#10;
	a_a = 1;
	a_b = 3;
end


initial 
begin
	$dumpfile("ram_test.vcd");
	$dumpvars(0, ram_test);
end

always 
	#5 clk = !clk;

initial
	#100 $finish;

endmodule
