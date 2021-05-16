module test_sv;
  bus uuu ();
  mot     m0 (.u1(uuu));
  stimul  m1 (.u2(uuu));
  complex m2 (uuu.data_in, uuu.data_out[0], uuu.data_out[1], uuu.data_out[2]); 
endmodule
