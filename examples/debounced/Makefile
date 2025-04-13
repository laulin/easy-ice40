build:
	echo "nothing"

test_debouncer:
	iverilog -o debouncer_tb debouncer.v debouncer_tb.v
	vvp debouncer_tb
	gtkwave debouncer_tb.vcd

test_strobe:
	iverilog -o strobe_tb strobe.v strobe_tb.v
	vvp strobe_tb
	gtkwave strobe_tb.vcd