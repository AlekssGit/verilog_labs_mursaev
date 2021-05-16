module complex(data_in, data_out);
input wire [2:0] data_in;
output wire [2:0] data_out; 

wire [7:0] y; 		     //internal conections in module

decode (
	.data(data_in),
	.eq0(y[0]),
	.eq1(y[1]),
	.eq2(y[2]),
	.eq3(y[3]),
	.eq4(y[4]),
	.eq5(y[5]),
	.eq6(y[6]),
	.eq7(y[7])
	);

// Change according to your variant
or mod2(data_out[0], y[0], y[1], y[6]);
or mod3(data_out[1], y[0], y[3], y[7]);
or mod4(data_out[2], y[1], y[3], y[5], y[7]);

endmodule