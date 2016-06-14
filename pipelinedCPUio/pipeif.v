module pipeif( pcsource,pc,bpc,rpc,jpc,npc,pc4,ins,rom_clk );

	input [31:0] pc,bpc,rpc,jpc;
	input [1:0] pcsource;
	input rom_clk;
	output [31:0] npc,pc4,ins;

	mux4x32 selectnewpc (pc4,bpc,rpc,jpc,pcsource,npc);
	cla32 pc_plus4 (pc,32'h4,1'b0,pc4);
	lpm_rom_irom irom (pc[7:2],rom_clk,ins);// instruction memory.
	//pipeimem inst_mem(pc,ins);
	/*
	module pipeimem(a,inst);
		input [31:0] a;
		output [31:0] a;
		lpm_rom lpm_rom_component (.address(a[7:2],.q(inst)));
		defparam lpm_rom_component.lpm_width =32,
			lpm_rom_component.lpm_widthad =6,
			lpm_rom_component.lpm_numwords ="unused",
			lpm_rom_component.lpm_file ="pipeimem.mif",
			lpm_rom_component.lpm_indata ="unused",
			lpm_rom_component.lpm_outdata ="unused",
			lpm_rom_component.lpm_address_control ="unregistered";
	endmodule
	*/
endmodule
