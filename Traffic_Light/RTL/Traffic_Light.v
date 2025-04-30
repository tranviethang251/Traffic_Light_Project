module Traffic_Light 
  #(parameter CL_PERIOD_TIME = 100, 
    parameter YELLOW_LIGHT_TIME = 3,
    parameter RED_LIGHT_TIME = 18 , 
    parameter GREEN_LIGHT_TIME = 15,
    parameter pCount_Width = $clog2(RED_LIGHT_TIME)) 
    (
     input clk,
     input en,
     input rstb,
     output red_light ,
     output green_light,
     output yellow_light,
     output [pCount_Width-1:0] cnt_out_num
    ) ; 
  // local parameter 
  //internal signal decleration 
     wire second_tick ; // module second_counter 
     wire [pCount_Width-1:0] Load_Count; // module Light_Controller 
     wire ctr_load ; // module Light_Controller 
     wire light_tick ; // module Light_Counter 
  // module instantiation 
    // second counter 
    Second_Counter  #(.CL_PER_TIME(CL_PERIOD_TIME)) unit_1 (.clk(clk),.rstb(rstb),.en(en),.sec_tick(second_tick)) ; 
    // Light_Controller  
    Light_Controller  #(.pRed_Count_Sec(RED_LIGHT_TIME),.pYellow_Count_Sec(YELLOW_LIGHT_TIME),.pGreen_Count_Sec(GREEN_LIGHT_TIME)) uint_2
                             (.clk(clk),.rstb(rstb),.en(en),.light_tick(light_tick),.Load_Count(Load_Count),.ctr_load(ctr_load),.red_light(red_light),.green_light(green_light),
                             .yellow_light(yellow_light)) ; 
    // Light_Counter 
    Light_Counter  #(.pRed_Count_Sec(RED_LIGHT_TIME),.pYellow_Count_Sec(YELLOW_LIGHT_TIME),.pGreen_Count_Sec(GREEN_LIGHT_TIME)) unit_3
                          (.clk(clk),.rstb(rstb),.en(en),.ctr_load(ctr_load),.sec_tick(second_tick),.Load_Count(Load_Count),.light_tick(light_tick),.cnt_out(cnt_out_num)) ; 
  endmodule 