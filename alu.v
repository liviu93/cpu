`include "alu_ops.v"

module alu(
	op_a,
	op_b,
	result,
	cin,
	cout,
	opcode
);

input op_a, op_b, cin;
input[2:0] opcode;

output result, cout;

wire op_a, op_b, cin;
wire[2:0] opcode;

reg result, cout;


always @(*) 
begin
	{result , cout} = 0;

	case (opcode)
		`ALU_ADD	:	result = op_a + op_b;
		`ALU_AND	:	result = op_a & op_b;
		`ALU_NOT	:	result = ~op_a;
		`ALU_ADDC	:	begin
				result  = op_a ^ op_b ^ cin;
				cout	= (op_a & op_b) | (op_a & cin) | (op_b & cin);
		end
		`ALU_XOR	:	result = op_a ^ op_b;	
		`ALU_SUB	:	result = op_a - op_b;	
	endcase
end


endmodule
