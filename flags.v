/*
*	carry
*	zero
*/

`define SET_CARRY (1 << 1)
`define SET_ZERO  (1 << 0)

module flags(
	cin,
	cout,
	reset,
	clk
);

parameter WIDTH = 2;

input reset, clk, cin;
output cout;

reg mem;

assign cout = mem;

always @ (negedge clk)
begin
	if (reset)
		mem <= 1'b0;
	else
		mem <= cin;
end



endmodule


