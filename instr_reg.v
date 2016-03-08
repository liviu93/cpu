module instr_reg (
	out,
	data,
	clk,
	en
);

localparam WIDTH = 18;

output[WIDTH-1:0] out;
input[WIDTH-1:0] data;
input clk, en;

reg[WIDTH-1:0] mem;

assign out = mem;

always @(posedge clk)
begin
	if (en)
		mem <= data;
end

endmodule


