module Second_Counter 
  #( parameter CL_PER_TIME = 100) 
  ( input clk,
    input rstb,
    input en,
    output sec_tick) ;
// local parameter 
localparam pCounter_Width = $clog2(CL_PER_TIME) ; 
// internal signal decleration 
wire [pCounter_Width-1:0] End_Count_Num = CL_PER_TIME - 1 ;
reg [pCounter_Width-1:0] Cl_Per_Count ; 
wire tick ; 
reg de_tick ; 
// body 
// Clock period counter 
always@(posedge clk or negedge rstb) begin 
  if(~rstb) Cl_Per_Count <= 0 ; 
  else if(en) Cl_Per_Count <= (Cl_Per_Count==End_Count_Num) ? 0 : Cl_Per_Count + 1 ; 
  end 
// edge detector 
always@(posedge clk or negedge rstb) begin 
  if(~rstb) de_tick <= 0 ;
  else de_tick <= tick ; 
  end 
assign tick = (Cl_Per_Count == End_Count_Num) ? 1 : 0 ;
// output 
assign sec_tick = tick&(~de_tick); // output second tick ;
endmodule 
