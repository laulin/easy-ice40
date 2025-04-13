build:
	yosys -s synth.sys
	nextpnr-ice40 --hx8k --json top.json --pcf /usr/share/ice40/icefun/pinout.pcf --asc top.asc --package cb132
	icepack top.asc top.bin
	icefunprog /dev/ttyACM0 top.bin

test_debouncer:
	iverilog -o debouncer_tb debouncer.v debouncer_tb.v
	vvp debouncer_tb
	gtkwave debouncer_tb.vcd

test_strobe:
	iverilog -o strobe_tb strobe.v strobe_tb.v
	vvp strobe_tb
	gtkwave strobe_tb.vcd