module test;
parameter delay = 6;
parameter truth_table_0 = 8'b00100011; //8'b10000000; 
parameter truth_table_1 = 8'b00111001;
parameter truth_table_2 = 8'b01010101;
//wire  z_0,z_1,z_2;
wire [2:0] z;
reg [2:0] stim;
reg [3:0] j;
reg [3:0] i;
reg  chech_point,error;
wire vt_0, vt_1, vt_2;

initial 
begin							// stimulator 
	chech_point=0;
	// for (i = 0; i <= 2; i = i+1)
	 for (j=0; j<=7;j=j+1) 
	 begin
		  #10 ; 
		  stim=j;
		  chech_point = # delay 1;
		  #3 ;
		  chech_point = 0;  
    end
end

assign  vt_0 = truth_table_0[stim] ;
assign  vt_1 = truth_table_1[stim] ;
assign  vt_2 = truth_table_2[stim] ; 

complex m1 (.x_in(stim),.z_0(z[0]),.z_1(z[1]),.z_2(z[2]));

always @ (posedge chech_point) //tester   
    error = (z[0] == vt_0 & z[1] == vt_1 & z[2] == vt_2) ?  0:1;
endmodule
