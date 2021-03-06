module control_unit(clock, reset, start, y, c_sh_rg, c_cnt, ready);  
input clock, reset, start;
input y;
output c_sh_rg, c_cnt, ready;
parameter n=8;
enum {init,cycle} state;
wire clock, reset, start,
      y;// analyzing bit of word

reg      ready;
reg  [1:0]c_sh_rg; //control signal for module shift_reg
reg [1:0] c_cnt; //control signal for module counter
int k;
    
always @ (negedge clock, posedge reset)
begin 
	if (reset)
	begin 
		state = init; 
		ready = 0; 
	end
   else 
		case (state) 
			init: 
			begin
				if (start) 
				begin 
					state = cycle; 
					ready = 0; k = 0;
					c_sh_rg = 3; // was "1"
					c_cnt = 3; // loading
            end
			end
         cycle: 
			begin
				if (k==n) // control cycles count 
            begin 
					ready = 1; 
					k = 0; 
               c_sh_rg = 0; 
					c_cnt = 0;// blocking load bits
					state = init;
            end
            else  
				begin 
					//ready = 0;
					c_cnt[1] = y; c_cnt[0] = 0; // sum/save
               c_sh_rg = 2; // turn on shift reg
               k = k+1;
            end
			end
		endcase;
end
endmodule