module struct_l6(clock, reset, start, ready, in_data, result);

parameter data_size = 8;

//input logic i_clock;				// input clock
//output logic [6:0] lcd;			// lcd semisegment pins
//output logic [3:0] digits;		//control semisegment digits


input logic clock;
input logic start;
input logic reset;
input logic [data_size - 1 : 0] in_data;
output logic ready;
output logic [data_size - 1 : 0] result;

//logic clock;
//logic lcd_inv;
//assign lcd = ~lcd_inv;

////Turn on digigtal 1
//assign digits[0] = 1'b0;
//assign digits[1] = 1'b1;
//assign digits[2] = 1'b1;
//assign digits[3] = 1'b1;

//generator  #(25000000) gen (i_clock, clock); 			//For working with board: 25000000; 

//semisegment sem (.number(result[3:0]), .result(lcd_inv));	//lcd_inv


mp_mult #(8) mult (in_data, clock, reset, start, result, ready);

endmodule


module mp_mult( in_data, clock, reset, start, result, ready);

parameter data_size = 8;

input logic clock,reset,start;
output logic ready;
input logic [data_size - 1 : 0]  in_data;
output logic [data_size - 1 : 0]  result; 

reg   [data_size - 1 : 0] yp;
reg   [1 : 0]    contr_sh_reg;
reg   [1 : 0]    contr_cnt;
reg cnt_carry_out;

counter #(data_size, data_size, "up") 
cnt (.clk(clock), .reset(reset), .s(contr_cnt), .carry_in(1'h1), .carry_out(cnt_carry_out), .dat_in(1'b0), .result(result)); 
 
shift_register #(data_size,1,"right") shift_mod(.clk(clock),.s(contr_sh_reg),.dr(1'b0),.dl(1'b0),.par_inp(in_data),.result(yp)) ;
  
control_unit #(data_size) control_mod (.clock(clock), .reset(reset), .start(start), .y(yp[0]), .c_sh_rg(contr_sh_reg), .c_cnt(contr_cnt), .ready(ready));

endmodule