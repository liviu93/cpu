module rom(
	address,
	data,
	cs,
	we, // write enabled
	oe // output enabled
);

parameter DATA_WIDTH = 18;
parameter ADDR_WIDTH = 4;
parameter RAM_DEPTH = 1 << ADDR_WIDTH;


input[ADDR_WIDTH-1:0] address;
input cs;
input we;
input oe;

inout[DATA_WIDTH-1:0] data;

reg[DATA_WIDTH-1:0] data_out;
reg[DATA_WIDTH-1:0] mem[0:RAM_DEPTH-1];


integer i;
initial
begin
	for (i=0; i<16; i=i+1) begin
		mem[i] = i;
	end
	mem[0] = 18'b0110_11_0000_0100_1010;
	mem[1] = 18'b1011_00_0000_0000_0000;
	mem[2] = 18'b1111_00_0000_0000_0000;
end

assign data = ( cs && oe && !we) ? data_out : {DATA_WIDTH{1'bz}};

always @ (address or data or cs or we)
begin : MEM_WRITE
	if (cs && we) begin
		mem[address] = data;
	end
end

always @ (address or cs or we or oe)
begin : MEM_READ
	if (cs && !we && oe) begin
		data_out = mem[address];
	end
end


endmodule

