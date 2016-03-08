module addr_adder_test();

reg[3:0] base;
reg[1:0] offset;
wire[3:0] result;

addr_adder ar(
	.base(base),
	.offset(offset),
	.result(result)
);

initial 
begin
	#10;
	base = 4'b0001;
	offset = 2'b01;
	#10;
	base = 4'b0010;
	offset = 2'b11;
	#10;
	$finish;	
end



initial 
begin
	$dumpfile("add_adder_test.vcd");
	$dumpvars(0, addr_adder_test);
end



endmodule
