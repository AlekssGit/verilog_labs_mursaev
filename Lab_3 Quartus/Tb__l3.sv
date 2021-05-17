module Tb__l3(leds_data_out, i_clock, lcd, digits);
	input logic i_clock;				// input clock
	output logic [6:0] lcd;			// lcd semisegment pins
	output logic [3:0] digits;		//control semisegment digits
	output logic [2:0] leds_data_out; //connect to the leds
	logic [2:0] data_out;
	logic [2:0] data_in;
	
	logic clock;
	logic [6:0] lcd_inv;
	assign lcd = ~lcd_inv;
	assign leds_data_out = ~data_out;
	
	//Turn on digigtal 1
	assign digits[0] = 1'b0;
	assign digits[1] = 1'b1;
	assign digits[2] = 1'b1;
	assign digits[3] = 1'b1;
	
	generator  #(25000000) gen (i_clock, clock); 			//For working with board: 25000000; 
	
	semisegment sem (.number({1'b0, data_in}), .result(lcd_inv));	//lcd_inv

	counter cnt (.clock(clock), .q(data_in));
	complex m2 (.data_in(data_in), .data_out(data_out)); 
endmodule
