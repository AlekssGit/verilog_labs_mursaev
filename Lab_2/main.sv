//Without triggers

module main;
parameter truth_table= 8'b01000011;
wire  error;
reg x_0, x_1, x_2, z_logic, z_shenon, z_case, z_table;
reg [3:0] takt;

initial  begin
  x_0='b0;
  x_1='b0;
  x_2 ='b0;
  for (takt=0;takt!=8;takt=takt+1)
  begin
  #20 
   #5  x_0= takt[0];
       x_1= takt[1];
       x_2= takt[2];
  end
end

assign error = (z_logic == truth_table[{x_2, x_1, x_0}]) ? 0 : 1;

always @(x_0,x_1,x_2) 
begin         
  z_logic = (~x_0 & ~x_1 & ~x_2)|(x_0 & ~x_1 & ~x_2)|(x_2 & x_1 & ~x_0);
end

always @(x_0,x_1,x_2) 
begin
  if(x_1)
    z_shenon = (x_2) ? ~x_0 : 0;
  else
    z_shenon = (x_2) ? 0: 1;
end

always @(x_0,x_1,x_2) 
begin 
    case ({x_2, x_1, x_0})
      3'd0: z_case = 1;
      3'd1: z_case = 1;
      3'd2: z_case = 0;
      3'd3: z_case = 0;
      3'd4: z_case = 0;
      3'd5: z_case = 0;
      3'd6: z_case = 1;
      3'd7: z_case = 0;
   endcase
end

endmodule




//With triggers
/*
module main;
parameter truth_table=8'b01000011;

wire  error;
reg x_0, x_1, x_2, z1, z, z2, clock;
reg [3:0] takt;

initial  begin
  clock='b0;
  x_0='b0;
  x_1='b0;
  x_2 ='b0;
for (takt=0;takt!=8;takt=takt+1)
  begin
  #20  clock='b1;
   #5  x_0= takt[0];
       x_1= takt[1];
       x_2= takt[2];
   #5  clock = 'b0;
  end
end 	 

//D-latch with static control
/*always @(z1, clock)
begin
  if (clock)
    z = z1;
end

//D-latch with dynamic control positive edge - delay first takt
/*always @(posedge clock)
begin
    z <= z1;
end

//D-latch with dynamic control positive edge - delay second takt
always @(posedge clock)
begin
    z2 <= z;
end

assign 
    error=(z1==truth_table[{x_2, x_1, x_0}])? 0:1;
always @(x_0,x_1,x_2) 
begin         
        z1 = (~x_0 & ~x_1 & ~x_2) | (x_0 & ~x_1 & ~x_2) | (x_2 & x_1 & ~x_0);
end
endmodule

*/