module state_machine_numbers (in_data, reset, clock, out_data);
	parameter 	state_len 	= 3;
	parameter 	inp_len 	= 3;
	parameter 	out_len 	= 2;

	input 	wire 	[inp_len - 1:0] in_data;
	input 	wire			reset;
	input 	wire			clock;
	output	reg 	[out_len - 1:0] out_data;
	
  reg [state_len - 1:0] state;

  parameter y_0 = 2'b00;
  parameter y_1 = 2'b01;
  parameter y_2 = 2'b10;

  parameter x_0 = 3'b001;
  parameter x_1 = 3'b010;
  parameter x_2 = 3'b100;


always @ (posedge clock or posedge reset)
	begin 
		if (reset)  
		begin 
			state    <= 2'b00;
			out_data <= 2'b00; 
		end
		else
		begin
			case(state)
			2'b00: 	if       (in_data == x_0)	begin state <= 2'b00; out_data <= y_0; end  //001
				else  if (in_data == x_1)	begin state <= 2'b01; out_data <= y_0; end  //010
				else  if (in_data == x_2)	begin state <= 2'b11; out_data <= y_2; end  //100
				
			2'b01: 	if       (in_data == x_0)	begin state <= 2'b01; out_data <= y_0; end  //001
				else  if (in_data == x_1)	begin state <= 2'b10; out_data <= y_0; end  //010
				else  if (in_data == x_2)	begin state <= 2'b00; out_data <= y_0; end  //100
				
			2'b10: 	if       (in_data == x_0)	begin state <= 2'b10; out_data <= y_0; end  //001
				else  if (in_data == x_1)	begin state <= 2'b11; out_data <= y_0; end  //010
				else  if (in_data == x_2)	begin state <= 2'b01; out_data <= y_0; end  //100

			2'b11: 	if       (in_data == x_0)	begin state <= 2'b11; out_data <= y_0; end  //001
				else  if (in_data == x_1)	begin state <= 2'b00; out_data <= y_1; end  //010
				else  if (in_data == x_2)	begin state <= 2'b10; out_data <= y_0; end  //100
			endcase
		end
	end
endmodule

module state_machine_letters (in_data, reset, clock, out_data);
	parameter 	state_len 	= 3;
	parameter 	inp_len 	= 3;
	parameter 	out_len 	= 2;

	input 	wire 	[inp_len - 1:0] in_data;
	input 	wire			reset;
	input 	wire			clock;
	output	reg 	[out_len - 1:0] out_data;

enum { s0, s1, s2, s3 }   state; 

  parameter y_0 = 2'b00;
  parameter y_1 = 2'b01;
  parameter y_2 = 2'b10;

  parameter x_0 = 3'b001;
  parameter x_1 = 3'b010;
  parameter x_2 = 3'b100;

covergroup state_cov;
  t1:coverpoint state {bins idle ={s0};
                       bins rest = {s1, s2, s3};}
  t2: coverpoint state
     {
      bins  s_o = (s0=>s0), (s0=>s1), (s0=>s2), (s0=>s3);
      bins  s_1 = (s1=>s1), (s1=>s0), (s1=>s2), (s1=>s3);
      bins  s_2 = (s2=>s2), (s2=>s0), (s2=>s1), (s2=>s3);
      bins  s_3 = (s3=>s3), (s3=>s0), (s3=>s1), (s3=>s1);
     }
endgroup;


covergroup data_in_cov;
  t1:coverpoint in_data {	
				bins first  = (x_0 => x_1);
                       		bins second = (x_1 => x_2);
				bins third  = (x_2 => x_0);
			}
endgroup;

state_cov st; 
data_in_cov d_in;

initial
begin
	st = new;
	d_in = new;
end

always @ (posedge clock or posedge reset)
	begin 
		if (reset)  
		begin 
			state <= s0;
			out_data <= y_0; 
		end
		else
		begin
			st.sample();
			d_in.sample();
			
			case(state)
			s0: 	if       (in_data == x_0)	begin state <= s0; out_data <= y_0; end  //001
				else  if (in_data == x_1)	begin state <= s1; out_data <= y_0; end  //010
				else  if (in_data == x_2)	begin state <= s3; out_data <= y_2; end  //100
				
			s1: 	if       (in_data == x_0)	begin state <= s1; out_data <= y_0; end  //001
				else  if (in_data == x_1)	begin state <= s2; out_data <= y_0; end  //010
				else  if (in_data == x_2)	begin state <= s0; out_data <= y_0; end  //100
				
			s2: 	if       (in_data == x_0)	begin state <= s2; out_data <= y_0; end  //001
				else  if (in_data == x_1)	begin state <= s3; out_data <= y_0; end  //010
				else  if (in_data == x_2)	begin state <= s1; out_data <= y_0; end  //100

			s3: 	if       (in_data == x_0)	begin state <= s3; out_data <= y_0; end  //001
				else  if (in_data == x_1)	begin state <= s0; out_data <= y_1; end  //010
				else  if (in_data == x_2)	begin state <= s2; out_data <= y_0; end  //100
			endcase
		end
	end
endmodule

