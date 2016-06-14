module time_create(indt,outdt0,outdt1);
	//A14
	input indt;
	output outdt0;
	output outdt1;
	
	assign outdt1 = indt;
   assign outdt0 = ~indt;

endmodule
