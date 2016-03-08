`timescale 1ns / 10ps
`include "opcodes.v"

module alu_test();

reg op_a, op_b, cin;
reg[3:0] opcode;

wire result, cout;

alu al(
	.op_a(op_a),
	.op_b(op_b),
	.result(result),
	.cin(cin),
	.cout(cout),
	.opcode(opcode)
);


initial
begin
	opcode = `ADD;
	op_a = 1;
	op_b = 0;
	#10;
	opcode = `XOR;
	op_a = 1;
	op_b = 1;
	#10;
	opcode = `ADDC;
	op_a = 0;
	op_b = 0;
	cin = 1;
	#10;
	$finish;
end


initial 
begin
	$dumpfile("alu_test.vcd");
	$dumpvars(0, alu_test);
end


endmodule

