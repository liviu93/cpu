SRC = program_counter.v rep_counter.v counter.v rom.v cpu_test.v  alu.v comparator.v addr_adder.v adder.v mux2x1.v mux4x1.v demux1x2.v cu.v ram.v flags.v instr_reg.v
CC = iverilog

all:
	${CC} -o cpu ${SRC}
	vvp cpu




