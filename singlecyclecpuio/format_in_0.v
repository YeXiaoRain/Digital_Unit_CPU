module format_in_0(indt4,indt3,indt2,indt1,indt0,,outdt);
	input indt4,indt3,indt2,indt1,indt0;
	output [31:0] outdt;
	assign outdt[4]=indt4;
	assign outdt[3]=indt3;
	assign outdt[2]=indt2;
	assign outdt[1]=indt1;
	assign outdt[0]=indt0;
endmodule
