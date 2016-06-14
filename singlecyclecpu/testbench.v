`timescale 1ps/1ps
module testbench;
reg CLOCK_50M;
reg CLOCK_MEM;
reg RST_N;
wire [31:0] PC,INST,ALUOUT,MEMOUT;
wire IMEMCLK,DMEMCLK;
sc_computer sc_computer_inst
(
	.resetn(RST_N),
	.clock(CLOCK_50M),
	.mem_clk(CLOCK_MEM),
	.pc(PC),
	.inst(INST),
	.aluout(ALUOUT),
	.memout(MEMOUT),
	.imem_clk(IMEMCLK),
	.dmem_clk(DMEMCLK)
);
initial
begin
	CLOCK_50M = 0;
	while (1)
		#10 CLOCK_50M = ~CLOCK_50M;
end

initial
begin
	CLOCK_MEM = 1;
	while (1)
		#5 CLOCK_MEM = ~CLOCK_MEM;
end

initial
begin
	RST_N = 0;
	#10 RST_N = 1;
end

initial
begin
	$display($time,"CLOCK_50M=%d CLOCK_MEM=%d RST_N =%d", CLOCK_50M, CLOCK_MEM ,RST_N );
end
endmodule
