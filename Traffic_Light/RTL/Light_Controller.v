module Light_Controller 
  #(parameter pRed_Count_Sec = 18,
    parameter pYellow_Count_Sec = 3,
    parameter pGreen_Count_Sec = 15,
    parameter pCount_width = $clog2(pRed_Count_Sec)) 
    (
    input clk,
    input rstb,
    input en,
    input light_tick, 
    output [pCount_width-1:0] Load_Count ,
    output ctr_load ,
    output red_light , 
    output green_light,
    output yellow_light    
    ) ;
  // local parameter decleartion 
  localparam [pCount_width-1:0] Red_Count_Ini = pRed_Count_Sec-1 ; // initilizate Red Count 
  localparam [pCount_width-1:0] Yellow_Count_Ini = pYellow_Count_Sec-1;
  localparam [pCount_width-1:0] Green_Count_Ini = pGreen_Count_Sec-1; 
  localparam [1:0] IDLE = 2'd0 ;   // symbolize states 
  localparam [1:0] Yellow = 2'd1 ; 
  localparam [1:0] Red    = 2'd2 ; 
  localparam [1:0] Green  = 2'd3 ;
  // signal decleration 
  reg [1:0] curr_state ; 
  reg [1:0] next_state ;
  reg [pCount_width-1:0] Load_Light_Count; 
  // body 
  // register state
  always@(posedge clk or negedge rstb) begin 
  if(~rstb) curr_state <= IDLE ;
  else if(en) curr_state <= next_state ;
end  
  // next_state logic and output logic 
  always@(*) begin 
    next_state = IDLE ; 
    Load_Light_Count = Yellow_Count_Ini ; 
    case (curr_state) 
      IDLE : begin 
         next_state = Yellow ; 
      end 
      Yellow : begin 
         Load_Light_Count = Red_Count_Ini; 
         next_state = (light_tick==0) ? Yellow : Red ; 
      end 
      Red : begin 
         Load_Light_Count = Green_Count_Ini ; 
         next_state       = (light_tick==0) ? Red : Green ; 
      end 
      Green : begin 
         Load_Light_Count = Yellow_Count_Ini ; 
         next_state       = (light_tick==0) ? Green : Yellow ;
      end 
    endcase 
  end 
  //output logic 
  assign Load_Count = Load_Light_Count ;
  assign ctr_load  = (en&light_tick) ; 
  assign red_light  = curr_state[1]&(~curr_state[0])  ; 
  assign green_light = &(curr_state) ; 
  assign yellow_light = curr_state[0]&(~curr_state[1])  ; 
  endmodule 