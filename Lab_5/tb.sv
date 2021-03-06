module top;
	sys_bus bus (.*);
	mp_mult mod_mult (.dev(bus));
	test_bench prog_tb (.dev(bus)); 
endmodule

program test_bench (sys_bus.monit dev);
	class TEST_DATA;
	rand bit [dev.data_size : 0] data;
	constraint data_valid { data > 0; }
	endclass;
	TEST_DATA t_data;
	logic  [4:0] takt;
	int i = 1;
	int results [2][100];
	integer f;
  	initial 
    	begin 
  		f = $fopen("C:/Users/alvas/Documents/Univer/Mursaev/Lab_5/outputs/output.txt","w");

		if (f == 0) 
		begin
			$info ("couldn't open file");
			$finish;
		end
		else
			$info ("file opened");

		dev.clock = 0; 
		dev.reset = 0; 
		dev.in_data = 8'hfa;
          	#15;
          	dev.reset = 1;
          	#15 
		dev.reset = 0;

		t_data = new();
		assert (t_data.randomize());

		repeat(110)
		begin
			while(t_data.randomize() != 1);
			dev.in_data = t_data.data;
			for (takt = 1; takt < 11; takt = takt + 1)
 			begin
				if(takt == 1)
				begin
					dev.start = 1;
				end
				else if(takt == 2)
				begin
					dev.start = 0;
				end

          			#5 
				dev.clock = 1;

          			#5 
				dev.clock = 0;

				if(dev.ready)
				begin
					$fwrite(f,"%0d) %x - %b - %0d\n", i, dev.in_data, dev.in_data, dev.result);
				end
			end
			i++;
          	end 

  		$fclose(f); 
		$info ("file closed"); 
      	end
endprogram