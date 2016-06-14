`timescale 1ps/1ps
module testbench;
reg RESETN,CLK,MEMCLK;
wire [31:0] PC,INST,EALU,MALU,WALU;
pipelined_computer pipelined_computer_inst
(
	.resetn(RESETN),
	.clock(CLK),
	.mem_clock(MEMCLK),
	.pc(PC),
	.inst(INST),
	.ealu(EALU),
	.malu(MALU),
	.walu(WALU)
);
initial
begin
	RESETN = 0;
	#10 RESETN = 1;
end
initial
begin
	CLK = 0;
	while (1) begin
		MEMCLK = ~CLK;
		#10 CLK = ~CLK;
	end
end

endmodule
