module decod(x_in,y_out);
parameter delay=3; 	//delay
parameter n=4;		// number of inputs
parameter u=8;		//number of outputs
input x_in;	  		//ports mode
output y_out;		//ports mode
wire [n-1:0] x_in;	//ports type
reg [u-1:0] y_out;	//ports type
reg [n:0]  i;		//counter for loop

always @ (x_in)		//operator is executed whenever x_in changes
 begin  
	# delay;
	for (i=0; i<u; i=i+1)
		y_out[i] =  x_in==i  ? 1:0;                    
end
endmodule