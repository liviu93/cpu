
module demux1x2(
	sel,
	in,
	out1,
	out2
);

parameter WIDTH = 4;

input sel;
input[WIDTH-1:0] in;
output reg [WIDTH-1:0] out1;
output reg [WIDTH-1:0] out2;


always @ (*) 
begin
	if (sel) begin
		out1 = in;
		out2 = {WIDTH{1'bz}};
	end 
	else begin
		out2 = in;
		out1 = {WIDTH{1'bz}};
	end
end


endmodule

