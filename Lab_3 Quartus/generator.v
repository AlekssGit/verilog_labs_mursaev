module generator(
	input i_clk,
	output o_clk
	);
	
	parameter scaler = 100;
	reg[31:0] counter;
	always@(posedge i_clk)
	begin
		if(counter < scaler)
		begin
			counter ++;
		end
		else
		begin
			counter = 0;
			o_clk = ~o_clk;
		end
	
	end
endmodule