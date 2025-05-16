module seven_segment_led_BCD 
  ( input [3:0] in_sig , 
    output reg [6:0] led_seg_dis ) ; 
  // common cathode led - Turn On the Segment when Input signal asserted  
  // signal decleration 
  // body 
  always@(*) begin 
    led_seg_dis = 7'h0 ; 
  case(in_sig) 
    4'd0 : led_seg_dis = 7'h3F ; // 0
    4'd1 : led_seg_dis = 7'h06 ; // 1 
    4'd2 : led_seg_dis = 7'h5B ; // 2
    4'd3 : led_seg_dis = 7'h4F ; // 3
    4'd4 : led_seg_dis = 7'h66 ; // 4 
    4'd5 : led_seg_dis = 7'h6D ; // 5
    4'd6 : led_seg_dis = 7'h7D ; // 6
    4'd7 : led_seg_dis = 7'h07 ; // 7
    4'd8 : led_seg_dis = 7'h7F ; // 8
    4'd9 : led_seg_dis = 7'h6F ; // 9
  endcase 
  end 
  // dot display 
endmodule 