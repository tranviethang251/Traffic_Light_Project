module arithmetic_unit_for_dis 
#  ( parameter p_width = 10 ) 
  (
   input  [p_width-1:0] in_sig, 
   output [p_width-5:0] tens_digit,
   output [3:0] unit_digit ) ; 
   // signal declearation 
   assign tens_digit = in_sig/10 ;
   assign unit_digit = in_sig%10; 
endmodule 