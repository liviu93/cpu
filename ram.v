module ram(
	clk,
	address_a,
	address_b,
	dest,
	data,
	out_a,
	out_b,
	we
);

parameter ADDR_WIDTH = 4;
parameter RAM_DEPTH = 16;

input[ADDR_WIDTH-1:0] address_a;
input[ADDR_WIDTH-1:0] address_b;
input[ADDR_WIDTH-1:0] dest;
input data;
input clk;
input we;

output out_a, out_b;

reg [RAM_DEPTH-1:0] mem;

assign out_a = mem[address_a];
assign out_b = mem[address_b];


always @ (negedge clk)
begin : MEM_WRITE
	if (we)
		mem[dest] <= data;
end

initial
begin
	mem = 16'b0;	
	mem[0] = 1;
	mem[1] = 0;
	mem[2] = 0;
	mem[3] = 1;

	mem[4] = 0;
	mem[5] = 1;
	mem[6] = 1;
	mem[7] = 1;

end



endmodule

