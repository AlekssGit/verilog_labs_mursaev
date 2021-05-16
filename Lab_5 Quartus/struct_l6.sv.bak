interface sys_bus();
parameter data_size = 8;
logic clock,reset,start,ready;
logic [data_size - 1 : 0]  in_data;
logic [data_size - 1 : 0]  result; 

modport device (input in_data, clock, reset, start, output result, ready);

modport monit (output in_data, clock, reset, start, input result, ready);


endinterface

module mp_mult( sys_bus.device dev);

reg   [dev.data_size - 1 : 0] yp;
reg   [1 : 0]    contr_sh_reg;
reg   [1 : 0]    contr_cnt;
reg cnt_carry_out;

counter #(dev.data_size, dev.data_size, "up") 
cnt (.clk(dev.clock), .reset(dev.reset), .s(contr_cnt), .carry_in(1'h1), .carry_out(cnt_carry_out), .dat_in(1'b0), .result(dev.result)); 
 
shift_register #(dev.data_size,1,"right") shift_mod(.clk(dev.clock),.s(contr_sh_reg),.dr(1'b0),.dl(1'b0),.par_inp(dev.in_data),.result(yp)) ;
  
control_unit #(dev.data_size) control_mod (.clock(dev.clock), .reset(dev.reset), .start(dev.start), .y(yp[0]), .c_sh_rg(contr_sh_reg), .c_cnt(contr_cnt), .ready(dev.ready));

endmodule