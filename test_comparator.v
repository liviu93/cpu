`timescale 1ns / 10ps

module test_comparator();

wire less, equal , greater;

reg a, b;

comparator x(
	.a(a),
	.b(b),
	.less(less),
	.equal(equal),
	.greater(greater)
);

initial
begin
	a = 1;
	b = 1;
	#10;
	a = 0;
	b = 0;
	#10;
	a = 1;
	b = 0;
	#10;
	a = 0;
	b = 1;
	#10;
	$finish;
end


initial 
begin
	$dumpfile("test_comparator.vcd");
	$dumpvars(0, test_comparator);
end


endmodule

