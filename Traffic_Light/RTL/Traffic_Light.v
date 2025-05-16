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
     output [pCount_Width-1:0] cnt_out_num,
     output [6:0] tens_digit_led ,
     output [6:0] unit_digit_led
    ) ; 
  // local parameter 
  //internal signal decleration 
     wire second_tick ;                     // module second_counter 
     wire [pCount_Width-1:0] Load_Count;    // module Light_Controller 
     wire ctr_load ;                        // module Light_Controller 
     wire light_tick ;                      // module Light_Counter 
     wire [pCount_Width-5:0] tens_digit ;   // module arithmetic_unit_for_led 
     wire [3:0] unit_digit ;                // module arithmetic_unit_for_led 
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
    // Display second counter 
    //  arithmetic calculating
    arithmetic_unit_for_dis  #(.p_width(pCount_Width)) unit_4 (.in_sig(cnt_out_num),.tens_digit(tens_digit),.unit_digit(unit_digit)) ; 
    // led display
    wire [3:0] tmp_tens_digit ; 
    assign tmp_tens_digit = tens_digit ;
    seven_segment_led_BCD unit_5 (.in_sig(tmp_tens_digit),.led_seg_dis(tens_digit_led)) ;  // tens digit led 
    seven_segment_led_BCD unit_6 (.in_sig(unit_digit),.led_seg_dis(unit_digit_led)) ; // unit digit led 
  endmodule 
