module top();
	parameter inp_len = 3;
  	parameter out_len = 2;
  	logic [ 0: inp_len-1] in_data ;
  	logic [ 0: out_len-1] out_data_1;
	logic [ 0: out_len-1] out_data_2;
  	logic clock, reset;

	state_machine_numbers	v2 ( .in_data(in_data), .out_data(out_data_1), .reset(reset), .clock(clock) );

	generator #(inp_len) 	v1 ( .in_data(in_data), .clock(clock), .reset(reset) )  ;

	state_machine_letters	v3 ( .in_data(in_data), .out_data(out_data_2), .reset(reset), .clock(clock) );
endmodule

program generator (in_data,clock,reset);
	parameter inp_len = 2;
  	output   logic [ 0: inp_len-1]in_data ;
  	output logic clock,reset;

	logic  [4:0] takt;
  	initial 
    	begin 
		clock=0; 
		reset=0; 
		in_data=0;
          	#5;
          	reset=1;
          	#5 
		reset=0;
          	forever 
		begin
			for (takt=1; takt<=12; takt=takt+1)
 			begin
    				case (takt)
    				1: in_data=3'b001;
    				2: in_data=3'b010;
				3: in_data=3'b010;
				4: in_data=3'b010;
				5: in_data=3'b010;
				6: in_data=3'b100;
    				7: in_data=3'b100;  
		                8: in_data=3'b100; 
	                	9: in_data=3'b100; 
    				10: in_data=3'b001;
				11: in_data=3'b001;
				12: in_data=3'b001;
    				endcase
          			#5 
				clock=1;
          			#5 
				clock=0;
			end
          	end 
      	end
   
endprogram