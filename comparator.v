module comparator(
	a,b,
	less,equal,greater
);

input[1:0] a,b;
output less, equal, greater;
	
wire[1:0] a, b;
wire less, equal, greater;


assign less = (a < b) ? 1 : 0;
assign equal = (a == b) ? 1 : 0;
assign greater = (a > b) ? 1 : 0;



endmodule

