build:
	echo "nothing"

test_debouncer:
	iverilog -o debouncer_tb debouncer.v debouncer_tb.v
	vvp debouncer_tb
	#gtkwave debouncer_tb.vcd