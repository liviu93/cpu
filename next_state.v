if (opcode_new == `JMP)
	next_state = BRANCH_TAKEN;
else if (opcode_new == `JC) begin
if (carry)
	next_state = BRANCH_TAKEN;
else 
	next_state = BRANCH_NOT_TAKEN;			
end
else if (`IS_HLT)
	next_state = STOP;
else if (`IS_IMM)
	next_state = ALU_IMM;
else 
	next_state = ALU_SRC;
