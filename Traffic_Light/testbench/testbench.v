`timescale 1 ns/1 ps
module testbench ; 
// localparameter 
localparam pCLOCK_PERIOD_TIME = 100 ; 
localparam pRED_CNT_INIT    = 18  ;
localparam pGREEN_CNT_INIT  = 15  ; 
localparam pYELLOW_CNT_INIT = 3   ;
localparam pCount_Width     = $clog2(pRED_CNT_INIT) ; 
// variables 
reg clk ;
reg rstb ; 
reg en ; 
wire Red_Light ; 
wire Yellow_Light; 
wire Green_Light ; 
wire [pCount_Width-1:0] cnt_out_num ; 
wire [6:0] tens_digit_led ; 
wire [6:0] unit_digit_led ;
// body 
// CLOCK GENERATION
always begin 
  #(pCLOCK_PERIOD_TIME/2) clk = 1'b1 ; 
  #(pCLOCK_PERIOD_TIME/2) clk = 1'b0 ;
end
// 
initial begin 
  clk = 1'b0 ; 
  rstb = 1'b0 ; 
  en   = 1'b0 ; 
  #(pCLOCK_PERIOD_TIME*5) 
  rstb = 1'b1 ; 
  en   = 1'b1 ; 
  #(200000*pCLOCK_PERIOD_TIME)  ;
  $stop; 
end 
// Unit Under Test 
Traffic_Light #(.CL_PERIOD_TIME(pCLOCK_PERIOD_TIME),.YELLOW_LIGHT_TIME(pYELLOW_CNT_INIT), 
               .RED_LIGHT_TIME(pRED_CNT_INIT), .GREEN_LIGHT_TIME(pGREEN_CNT_INIT)) 
               uut 
               (.clk(clk),.rstb(rstb),.en(en),.red_light(Red_Light),.yellow_light(Yellow_Light),.green_light(Green_Light),.cnt_out_num(cnt_out_num),
               .tens_digit_led(tens_digit_led),.unit_digit_led(unit_digit_led)) ; 
endmodule 
