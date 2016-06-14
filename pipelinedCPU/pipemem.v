module pipemem (we,addr,datain,clk,dmem_clk,dataout);
	//( mwmem,malu,mb,clock,mem_clock,mmo )
	input [31:0] addr,datain;
	input clk,we,dmem_clk;//,outclk;//??
	output [31:0] dataout;

	wire write_enable =we & ~clk;
	
	lpm_ram_dq_dram  dram(addr[6:2],dmem_clk,datain,write_enable,dataout );
	/*
	lpm_ram_dq ram(.data(datain),.address(addr[6:2]),.we(write_enable),.inclock(inclk),.outclock(outclk),.q(dataout));
	defparam ram.lpm_width =32;
	defparam ram.lpm_widthad =5;
	defparam ram.lpm_indata ="registered";
	defparam ram.lpm_outdata ="registered";
	defparam ram.lpm_file ="pipedemem.mif";
	defparam ram.lpm_address_control ="registered";
	*/
endmodule

