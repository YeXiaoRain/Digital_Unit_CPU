module time_create(indt,outdt0,outdt1);
	//A14
	input indt;
	output reg outdt0;
	output outdt1;
	
	assign outdt1 = indt;

	always @ (posedge indt)
		outdt0 <= ~outdt0;
	
	initial outdt0 <= 0;

endmodule
