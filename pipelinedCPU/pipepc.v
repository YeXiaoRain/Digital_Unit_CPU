module pipepc( npc,wpcir,clk,resetn,pc );
   input  [31:0] npc;
   input  wpcir,clk,resetn;
   output [31:0] pc;
   dffe32 next_pc(npc,clk,resetn,wpcir,pc);
   /*
   always @ (negedge resetn or posedge clk)
      if (resetn == 0) begin
         pc <= 0;
      end else begin
         if (wpcir == 1) 
			pc <= npc;
      end
	*/
   // resetn=1 and (wpcir=1 改变) clk poseedge pc=npc
endmodule