module flags_test();

reg clk;
reg cin;
reg reset;


flags ff(
	.clk(clk),
	.cin(cin),
	.reset(reset)
);



initial 
begin
	clk = 0;
	#5;
	reset = 1;
	#5;
	reset = 0;
	#5;
	cin = 1;
	#5;
	cin = 0;
end

always
	#5 clk = !clk;

initial 
begin
	$dumpfile("flags_test.vcd");
	$dumpvars(0, flags_test);
end

initial
	#100 $finish;


endmodule
