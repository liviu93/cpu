`timescale 1ns / 10 ps
`define D_W 18
`define A_W 4

module rom_test();


reg cs , we, oe;

reg[`A_W-1:0] address;
wire[`D_W-1:0] data;


reg[`D_W-1:0] data_h;

rom xx(
	.address(address),
	.data(data),
	.cs(cs),
	.we(we),
	.oe(oe)
);

assign data = data_h;

initial
begin
	#10;
	address = 0;
	data_h = 18'haf45;
	we = 1;
	oe = 0;
	cs = 1;
	#10;
	address = 1;
	data_h = 18'haa31;
	we = 1;
	oe = 0;
	cs = 1;
	#10;
	address = 0;
	we = 0;
	oe = 1;
	cs = 1;
	#10;
	$finish;
end



initial 
begin
	$dumpfile("rom_test.vcd");
	$dumpvars(0, rom_test);
end



endmodule

