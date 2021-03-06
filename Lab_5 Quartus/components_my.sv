 //-------
  module counter (clk,reset,s,carry_in, carry_out,dat_in,result);       
/*  s=> 
   00 - no oper
--  10 -increm for 'bidir'
--  01 - decrement  for 'bidir'
--  10 or 01 - inc for 'up' and decrement  'dowm'
--  11 -load */
     
 parameter  num_bits=8;
 parameter max = num_bits - 1;
 parameter  dir= "up" ; // dir  := 'up','down','bidir'
 
 input clk,reset, s,carry_in, dat_in;
 output carry_out,result;
 reg [num_bits-1:0] par_out; 
  wire [num_bits-1:0] result;
   reg carry_out;
    reg [1:0] s;
 reg carry_in;
 assign result=par_out;      
 
 always @(result, dir)
   if ((dir=="up") && (s!=2'b00) )     
             carry_out=(par_out==max) ? 1:0;               
   else if  ((dir=="down") && (s!=2'b00))
         carry_out=(par_out==0) ? 1:0;               
        else if  (dir=="bidir")
               if  (s==2'b10)  //up
                  carry_out= (par_out== max) ? 1:0;                                       
               else if (s==2'b01)  //down
                       carry_out= (par_out== 0) ? 1:0;
                      
always @(posedge clk  or posedge reset)
if (reset) par_out=0;
else if (dir=="up" )   
           if (s==2'b11)  par_out<=dat_in;
            else if (s==2'b10 || s==2'b01)
		begin 
                  par_out<=par_out+carry_in;
		end
                        
   else  if (dir=="down" ) 
          if (s==2'b11)  par_out<=dat_in;
          else if (s==2'b10 || s==2'b01) 
		begin 
                  par_out<=par_out-carry_in;
		end
           
    else  if (dir=="bidir" )             
               if (s==2'b11)par_out<=dat_in ;
                else if (s==2'b01)                                  
                                   par_out<=par_out+carry_in;
                     else   //(oper="10") 
                                  par_out<=par_out-carry_in;                                                                                                                                                                                                          
       
endmodule


 //----------------
  module shift_register (clk,s,dl,dr,par_inp,result);       
/*  00 - no oper
--  10 -shift letf for 'bidir'
--  01 -shift right for 'bidir'
--  10 or 01 - shift left for 'left' anf shift right for 'right'
--  11 -load */
      
  parameter  num_bits=8; 
  parameter  shift_len=1;
  parameter  dir= "left" ; // dir  := 'left','right','bidir'
  
  input clk,s,dr,dl, par_inp;
  output result;
  wire [num_bits-1:0] result;// avoid inoit
  wire clk,dr,dl;
  wire [1:0] s;
  wire[num_bits-1:0] par_inp;
  reg [num_bits-1:0]  par_out,par_outpr;     
     
  assign // fix ntw state
         result=par_out;      
 
 always @(posedge clk) // prepare new state
if (dir=="left" )
   begin
            if (s==2'b11)  par_out<=par_inp;
             else if (s==2'b10 || s==2'b01) begin
                   par_outpr=par_out<<shift_len;                         
                   par_outpr[0]=(shift_len==1)?  dl:0 ;
                   par_out<=par_outpr;
                                               end   
   end       
 
else  if (dir=="right" )       
          begin
           if (s==2'b11)  par_out<=par_inp;
          
            else if (s==2'b10 || s==2'b01) begin
                  par_outpr=par_out>>shift_len;                        
                    par_outpr[num_bits-1]= (shift_len==1)?  dr:0 ;
                     par_out<=par_outpr;
                                                 end   
          end  
  
     else  if (dir=="bidir" )    
            begin               
                if (s==2'b11)par_out=par_inp ;
                 else if (s==2'b01)
                                  begin
                                    par_outpr=par_out<<shift_len;                                         
                                    par_outpr[0]=(shift_len==1)?  dl:0 ;
                                    par_out<=par_outpr;
                                   end   
                   
                         else   //(oper="10") 
                                   begin
                                           par_outpr=par_out>>shift_len;                                                 
                                          par_outpr[num_bits-1]= (shift_len==1)?  dr:0 ;
                                          par_out<=par_outpr;
                                                                         
                                     end     
            end  // bidir;
endmodule