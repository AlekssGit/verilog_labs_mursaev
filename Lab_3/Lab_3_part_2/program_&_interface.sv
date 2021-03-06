interface bus();
// interface chain composition
logic check_point;
logic [2:0] data_in;
logic [2:0] data_out;
// interface modes for testing blocks

modport stim (output data_in, data_out, check_point);

modport monit (input data_in, data_out, check_point);

modport dut (input data_in, output data_out);

endinterface

program stimul (bus.stim u2);
  parameter delay = 6;
  integer j, i;
  initial
    begin
      uuu.check_point = 0;
     for (i = 0; i <= 2; i = i+1)
      for(j = 0; j <= 7; j = j + 1)
        begin
         #10;
         u2.data_in = j;
         u2.check_point = #delay 1;
         #3;
         u2.check_point = 0;
        end	 
    end
endprogram

module mot (bus.monit u1);
// data_out should be:         04362417
  parameter truth_table_1 = 8'b01000011;
  parameter truth_table_2 = 8'b10001001;
  parameter truth_table_3 = 8'b10101010;
  logic vt_1, vt_2, vt_3;
  time c_time;
  assign vt_1 = truth_table_1[u1.data_in];
  assign vt_2 = truth_table_2[u1.data_in];
  assign vt_3 = truth_table_3[u1.data_in];
  always @(posedge u1.check_point)
  begin
    c_time = $time; // Fix model time assertion
    assert (u1.data_out[0] == vt_1) $info("correct first at %0t", c_time);
    	else $error("error first at %0t", c_time);
    assert (u1.data_out[1] == vt_2) $info("correct second at %0t", c_time);
    	else $error("error second at %0t", c_time);
    assert (u1.data_out[2] == vt_3) $info("correct third  at %0t", c_time);
    	else $error("error third at %0t", c_time);
  end
endmodule
