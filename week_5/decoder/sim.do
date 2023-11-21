vlog -work work -stats=none D:\SEMICON_VERILOG_COURCES\week_5\decoder\*.v
vsim work.basic_test
add wave -r -position insertpoint sim:/basic_test/*
run -all