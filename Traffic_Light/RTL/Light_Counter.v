module Light_Counter 
  #(parameter pRed_Count_Sec = 18,
    parameter pYellow_Count_Sec = 3,
    parameter pGreen_Count_Sec = 15,
    parameter pCount_width = $clog2(pRed_Count_Sec)) 
  (input clk ,
   input en,
   input rstb, 
   input ctr_load,
   input sec_tick ,
   input [pCount_width-1:0] Load_Count , 
   output light_tick, 
   output [pCount_width-1:0] cnt_out) ;
   //signal decleration 
   reg [pCount_width-1:0] count ; 
   reg de_tick ; 
   wire tick ; 
   // body 
   always@(posedge clk or negedge rstb) begin 
     if(~rstb) count <= Load_Count ; 
     else if(en&sec_tick) count <= (ctr_load) ? Load_Count : count-1 ; 
   end 
   // tick edge detection 
   always@(posedge clk or negedge rstb) begin 
     if(~rstb) de_tick <= 0 ; 
     else de_tick <= tick ; 
  end 
  assign tick = (count==0) ? 1 : 0 ; 
  // output  
  assign light_tick = tick&sec_tick ;
  assign cnt_out = count ; 
 endmodule 
