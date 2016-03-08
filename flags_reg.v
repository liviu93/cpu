module flags_reg(
	out,
	data,
	load,
	enable,
	clk,
	reset
);


parameter WIDTH = 2;

output[WIDTH-1:0] out;

input[WIDTH-1:0] data;

input load, enable, clk, reset;

reg[WIDTH-1:0] out;

always @(posedge clk)
begin
	if (reset) begin
		out <= {WIDTH{1'b0}};
	end else 
	if (load) begin
		out <= data;
	end else 
	if (enable) begin 
		out <= out + 1;
	end
end


endmodule
