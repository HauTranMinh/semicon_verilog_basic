onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /Q4_tb/a
add wave -noupdate -radix decimal /Q4_tb/b
add wave -noupdate -radix decimal /Q4_tb/c
add wave -noupdate -radix decimal /Q4_tb/d
add wave -noupdate -radix decimal /Q4_tb/e
add wave -noupdate -radix decimal -childformat {{{/Q4_tb/f[7]} -radix decimal} {{/Q4_tb/f[6]} -radix decimal} {{/Q4_tb/f[5]} -radix decimal} {{/Q4_tb/f[4]} -radix decimal} {{/Q4_tb/f[3]} -radix decimal} {{/Q4_tb/f[2]} -radix decimal} {{/Q4_tb/f[1]} -radix decimal} {{/Q4_tb/f[0]} -radix decimal}} -subitemconfig {{/Q4_tb/f[7]} {-radix decimal} {/Q4_tb/f[6]} {-radix decimal} {/Q4_tb/f[5]} {-radix decimal} {/Q4_tb/f[4]} {-radix decimal} {/Q4_tb/f[3]} {-radix decimal} {/Q4_tb/f[2]} {-radix decimal} {/Q4_tb/f[1]} {-radix decimal} {/Q4_tb/f[0]} {-radix decimal}} /Q4_tb/f
add wave -noupdate -radix decimal /Q4_tb/x
add wave -noupdate -radix decimal /Q4_tb/y
add wave -noupdate -radix decimal /Q4_tb/z
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {60 ns}
