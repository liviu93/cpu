`timescale 1ns / 10 ps

`define OPCODE_ROM	rom_data[17:14]
`define DEST_ROM	rom_data[3:0]

`define OPCODE		ir_data[17:14]
`define REP			ir_data[13:12]
`define SRC1		ir_data[11:8]
`define SRC2		ir_data[7:4]
`define DEST		ir_data[3:0]

module cpu();

reg clk;
reg reset;

//// program counter
wire[3:0] pc_out;
wire pc_load;
wire pc_enable;
wire pc_reset;
/////////////////////

/// rep_counter
wire[1:0] rep_out;
reg[1:0] rep_datain;
reg rep_load;
wire rep_enable;
wire rep_reset;

/////////////////////

// instrction register
wire[17:0] ir_data;
wire ir_enable;



/// rom
reg rom_we;
reg rom_oe;
reg rom_cs;
wire[17:0] rom_data;


///// control signals
wire is_immediate;

wire alu_src1;
wire alu_result;
wire[2:0] alu_op;
wire alu_src2;

wire rep_less;
wire rep_equal;
wire rep_greater;

wire cout_alu;
wire cin_alu;
wire flags_reset;

wire[3:0] src2_addr;
wire[3:0] src1_addr;

wire[3:0] src1_imm;
wire[3:0] src2_imm;

wire ram_out_src2;
wire ram_out_src1;
wire[3:0] ram_src1;
wire[3:0] ram_src2;
wire[3:0] ram_dest;
wire ram_we;

wire src1_imm_bit;
wire src2_imm_bit;

comparator _comparator(
	.a(`REP),
	.b(rep_out),
	.less(rep_less),
	.equal(rep_equal),
	.greater(rep_greater)
);

cu _cu(
	.clk(clk),
	.rep_stop(rep_equal),
	.opcode_new(`OPCODE_ROM),	
	.opcode_old(`OPCODE),	
	.is_imm(is_immediate),
	.rep_reset(rep_reset),
	.rep_enable(rep_enable),
	.pc_enable(pc_enable),
	.pc_reset(pc_reset),
	.pc_load(pc_load),
	.flags_reset(flags_reset),
	.alu_op(alu_op),
	.reset(reset),
	.ram_we(ram_we),
	.carry(cout_alu),
	.ir_enable(ir_enable)
);

program_counter _pc(
	.out(pc_out),
	.data(`DEST_ROM),
	.load(pc_load),
	.enable(pc_enable),
	.clk(clk),
	.reset(pc_reset)
);

rep_counter _rep_counter(
	.out(rep_out),
	.data(rep_datain),
	.load(rep_load),
	.enable(rep_enable),
	.clk(clk),
	.reset(rep_reset)
);

rom _rom(
	.address(pc_out),
	.data(rom_data),
	.oe(rom_oe),
	.we(rom_we),
	.cs(rom_cs)
);

demux1x2 _demux_src1(
	.sel(is_immediate),
	.in(`SRC1),
	.out1(src1_imm),
	.out2(src1_addr)
);

demux1x2 _demux_src2(
	.sel(is_immediate),
	.in(`SRC2),
	.out1(src2_imm),
	.out2(src2_addr)
);

mux4x1 _src1_imm_bit(
	.sel(rep_out),
	.in(src1_imm),	
	.out(src1_imm_bit)
);

mux4x1 _src2_imm_bit(
	.sel(rep_out),
	.in(src2_imm),	
	.out(src2_imm_bit)
);

addr_adder _addr_adder_src1(
	.base(src1_addr),
	.offset(rep_out),
	.result(ram_src1)
);

addr_adder _addr_adder_src2(
	.base(src2_addr),
	.offset(rep_out),
	.result(ram_src2)
);

addr_adder _addr_adder_dest(
	.base(`DEST),
	.offset(rep_out),
	.result(ram_dest)
);

mux2x1 _alu_src1(
	.a(src1_imm_bit),
	.b(ram_out_src1),
	.out(alu_src1),
	.sel(is_immediate)
);

mux2x1 _alu_src2(
	.a(src2_imm_bit),
	.b(ram_out_src2),
	.out(alu_src2),
	.sel(is_immediate)
);

flags _flags(
	.clk(clk),
	.cin(cout_alu),
	.cout(cin_alu),
	.reset(flags_reset)
);

alu _alu(
	.op_a(alu_src1),
	.op_b(alu_src2),
	.result(alu_result),
	.cin(cin_alu),
	.cout(cout_alu),
	.opcode(alu_op)
);

ram _ram(
	.clk(clk),
	.address_a(ram_src1),
	.address_b(ram_src2),
	.dest(ram_dest),
	.data(alu_result),
	.out_a(ram_out_src1),
	.out_b(ram_out_src2),
	.we(ram_we)
);


instr_reg _ir(
	.out(ir_data),
	.data(rom_data),
	.en(ir_enable),
	.clk(clk)
);





initial 	
begin
	rom_cs = 1;
	rom_we = 0;
	rom_oe = 1;
	clk = 0;

	#3;
	reset = 1;
	#4;
	reset = 0;
end

always
	#5 clk = ~clk;



initial 
begin
	$dumpfile("cpu_test.vcd");
	$dumpvars(0, cpu_test);
end

initial
	#200 $finish;


endmodule


