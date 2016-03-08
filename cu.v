
`define AND		4'b0000
`define NOT		4'b0001
`define OR		4'b0010
`define XOR		4'b0011
`define SET		4'b0100
`define JMP		4'b0101
`define ADD		4'b0110
`define ADDI	4'b1000
`define SUB		4'b1001
`define SUBI	4'b1010
`define JC		4'b1011
`define HLT		4'b1111


`include "alu_ops.v"

module cu(
	clk,
	rep_stop,
	opcode_old,
	opcode_new,
	is_imm,
	rep_reset,
	rep_enable,
	pc_enable,
	pc_load,
	pc_reset,
	alu_op,
	flags_reset,
	ram_we,
	reset,
	carry,
	ir_enable
);

localparam INIT				= 3'b000;
localparam ALU_SRC			= 3'b001;
localparam ALU_SRC_CARRY	= 3'b010;
localparam ALU_IMM			= 3'b011;
localparam ALU_IMM_CARRY	= 3'b100;
localparam BRANCH_TAKEN		= 3'b101;
localparam BRANCH_NOT_TAKEN	= 3'b110;
localparam STOP				= 3'b111;

input clk;
input rep_stop;
input[3:0] opcode_new;
input[3:0] opcode_old;
input carry;
input reset;

output is_imm;
output rep_reset;
output rep_enable;
output pc_enable;
output pc_reset;
output pc_load;
output flags_reset;
output ram_we;
output reg[2:0] alu_op;
output ir_enable;


reg[2:0] current_state;
reg[2:0] next_state;

assign is_imm = ((current_state == ALU_IMM) | (current_state == ALU_IMM_CARRY));
assign rep_reset = ((current_state == INIT) | (current_state == ALU_SRC) | (current_state == ALU_IMM) | (current_state == STOP));
assign rep_enable = ((current_state == ALU_IMM_CARRY) | (current_state == ALU_SRC_CARRY));
assign pc_enable = ((current_state == ALU_IMM) | (current_state == ALU_SRC) | (current_state == BRANCH_NOT_TAKEN));
assign pc_reset = (current_state == INIT);
assign pc_load = (current_state == BRANCH_TAKEN);
assign flags_reset = (current_state == INIT);
assign ram_we = ((current_state != BRANCH_TAKEN) & (current_state != BRANCH_NOT_TAKEN) & (current_state != INIT) & (current_state != STOP));

assign ir_enable = ((current_state != ALU_IMM_CARRY) & (current_state != ALU_SRC_CARRY));

always @ (*)
begin
	case (current_state)

		INIT, ALU_SRC, ALU_IMM: begin
			if (opcode_old == `AND) 
				alu_op = `ALU_AND;
			else if (opcode_old == `ADD | opcode_old == `ADDI)
				alu_op = `ALU_ADD;
			else if (opcode_old == `NOT)
				alu_op = `ALU_NOT;
			else if (opcode_old == `XOR)
				alu_op = `ALU_XOR;
			else if (opcode_old == `SUB | opcode_old == `SUBI)
				alu_op = `ALU_SUB;
		end	

		INIT, ALU_SRC_CARRY, ALU_IMM_CARRY: begin
			if (opcode_old == `AND) 
				alu_op = `ALU_AND;
			else if (opcode_old == `ADD | opcode_old == `ADDI)
				alu_op = `ALU_ADDC;
			else if (opcode_old == `NOT)
				alu_op = `ALU_NOT;
			else if (opcode_old == `XOR)
				alu_op = `ALU_XOR;
			else if (opcode_old == `SUB | opcode_old == `SUBI)
				alu_op = `ALU_SUB;
		end	


	endcase	
end


always @ (negedge clk or posedge reset) 
begin
	if (reset) current_state <= INIT;
	else current_state <= next_state;	
end

`define IS_IMM (opcode_new == `ADDI | opcode_new == `SUBI)
`define IS_HLT (opcode_new == `HLT)

always @ (*) 
begin
	next_state = current_state;
	case (current_state)
		STOP, INIT: begin	
			`include "next_state.v"
		end

		ALU_SRC: begin
			if (!rep_stop)
				next_state = ALU_SRC_CARRY;
			else
				`include "next_state.v"
		end

		ALU_IMM: begin
			if (!rep_stop)
				next_state = ALU_IMM_CARRY;
			else
				`include "next_state.v"
		end

		BRANCH_TAKEN, BRANCH_NOT_TAKEN: begin
			`include "next_state.v"
		end

		ALU_SRC_CARRY: begin
			if (rep_stop) begin	
			// change the state
			`include "next_state.v"
			///////////////////
			end
			else
				next_state = ALU_SRC_CARRY;
		end

		ALU_IMM_CARRY: begin
			if (rep_stop) begin	
			// change the state
			`include "next_state.v"
			///////////////////
			end
			else
				next_state = ALU_IMM_CARRY;
		end


	endcase
end




endmodule




