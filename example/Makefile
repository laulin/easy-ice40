build:
	yosys -s synth.sys
	nextpnr-ice40 --hx8k --json blink.json --pcf /usr/share/ice40/icefun/pinout.pcf --asc blink.asc --package cb132
	icepack blink.asc blink.bin
	icefunprog /dev/ttyACM0 blink.bin

test:
	iverilog -o blink_tb blink.v blink_tb.v
	vvp blink_tb
	gtkwave blink_tb.vcd