onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/rstb
add wave -noupdate /testbench/en
add wave -noupdate /testbench/Yellow_Light
add wave -noupdate /testbench/Red_Light
add wave -noupdate /testbench/Green_Light
add wave -noupdate -radix symbolic -radixenum symbolic /testbench/uut/uint_2/next_state
add wave -noupdate -radix symbolic -radixenum symbolic /testbench/uut/uint_2/curr_state
add wave -noupdate /testbench/uut/uint_2/ctr_load
add wave -noupdate -radix unsigned /testbench/uut/unit_1/Cl_Per_Count
add wave -noupdate /testbench/uut/unit_1/sec_tick
add wave -noupdate -radix unsigned /testbench/uut/unit_3/count
add wave -noupdate -radix unsigned /testbench/cnt_out_num
add wave -noupdate /testbench/uut/unit_3/light_tick
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19827761853 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 266
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {19749505842 ps} {19895635640 ps}
