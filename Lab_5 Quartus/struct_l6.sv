module struct_l6(clock, i_reset, i_start, o_ready, in_data, lcd, digits);

parameter data_size = 8;

//input logic i_clock;				// input clock
output logic [6:0] lcd;			// lcd semisegment pins
output logic [3:0] digits;		//control semisegment digits


input logic clock;
input logic i_start;
input logic i_reset;
input logic [data_size - 1 : 0] in_data;
output logic o_ready;
logic [data_size - 1 : 0] result;

logic start;
assign start = ~i_start;
logic reset;
assign reset = ~i_reset;
logic ready;
assign o_ready = ~ready;

mp_mult #(8) mult (in_data, clock, reset, start, result, ready);


logic [3:0] ready_result;


always@ (posedge ready)
begin
	ready_result = result[3:0];
end

lcd lcd_show (.i_clock(clock), .data_dig_0(in_data[7:4]), .data_dig_1(in_data[3:0]), .data_dig_2(4'h0), .data_dig_3(ready_result), .digits(digits), .lcd_out(lcd));

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

module lcd (i_clock, data_dig_0, data_dig_1, data_dig_2, data_dig_3, digits, lcd_out);

input logic i_clock;
input logic [3:0] data_dig_0;
input logic [3:0] data_dig_1;
input logic [3:0] data_dig_2;
input logic [3:0] data_dig_3;
output logic [3:0] digits;
output logic [6:0] lcd_out;


reg [6:0] led_inv_dig_0;
reg [6:0] led_inv_dig_1;
reg [6:0] led_inv_dig_2;
reg [6:0] led_inv_dig_3;

assign led_inv_dig_2 = 7'b1000000; //symbol "-"

//Понижение частоты для переключения цифр, так как сегменты объединены в одну цепь
reg clk_led;
generator  #(100000) gen_led (i_clock, clk_led);

semisegment seg_dig_1 (.number(data_dig_1), .result(led_inv_dig_1));
semisegment seg_dig_0 (.number(data_dig_0), .result(led_inv_dig_0));

semisegment seg_dig_3 (.number(data_dig_3), .result(led_inv_dig_3));
//semisegment seg_dig_2 (.number(3'h0), .result(led_inv_dig_2));

always@(posedge clk_led)
begin
	if(digits[0] == 1'b0)
	begin
		digits[0] = 1'b1;
		digits[1] = 1'b0;
		digits[2] = 1'b1;
		digits[3] = 1'b1;
		
		lcd_out = ~led_inv_dig_1;
	end
	else if(digits[1] == 1'b0)
	begin
		digits[0] = 1'b1;
		digits[1] = 1'b1;
		digits[2] = 1'b0;
		digits[3] = 1'b1;
		
		lcd_out = ~led_inv_dig_2;
	end
	else if(digits[2] == 1'b0)
	begin
		digits[0] = 1'b1;
		digits[1] = 1'b1;
		digits[2] = 1'b1;
		digits[3] = 1'b0;
		
		lcd_out = ~led_inv_dig_3;
	end
	else
	begin
		digits[0] = 1'b0;
		digits[1] = 1'b1;
		digits[2] = 1'b1;
		digits[3] = 1'b1;
		
		lcd_out = ~led_inv_dig_0;
	end
end
endmodule