primitive table_func (z_out, in2, in1, in0);
output z_out;
input in2, in1, in0;
table
// in2, in1, in0 : z_out
	0 0 ?  :  1;
	0 1 ?  :  0;
	1 0 ?  :  0;
	1 1 0  :  1;
	1 1 1  :  0;
endtable
endprimitive