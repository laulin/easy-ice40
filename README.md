# ease-ice40

This repos contains envenment to manage ice40 and especially icefun as easy as possible. It's also a starter pack to work with a icefunboard.

## Requirement

You need docker must be installed

## Install

* make
* sudo make install

## what next ?

**easy-ice40** command is now reachable. By running it in you current working directory (i.e in your repository), you will have a bash with all software available :

* nextpnr-ice40
* yosys 
* fpga-icestorm 
* iverilog
* gtkwave
* icefunprog

A full working example is available `in example/`. 

### Bitstream

From you verilog to a programmed FPGA, steps are the following :

* yosys : synthetise the verilog to a json
* nextpnr-ice40 : convert the synthetisis to an ascii bitstream (pin mapping, ice40 model mapping, etc)
* icepack : convert the ascii bitstream to a binarybitstream, what the FPGA expect
* icefunprog : upload the bitstream into the FPGA

### Testing (benchmark)

Based on you verilog, you need to write another verilog file (xxx_tb.v for example), containing your tests. Than you need to run :

* iverilog : simulate the behabiour
* vvp : convert to *.vcd
* gtkwave : display traces

## Example

To use the example (after installation), go to the `example/` directory and run `sudo easy-ice40`. The current directory is mounted in `/work`. Plug you board and run `make`. If everything is **OK**, a led should blink. Congratulation !

To test the source code, you can run `make test`. After some second, GTKwave should appear; Add wave and you will see traces.

## useful link
* https://hardwarebee.com/ultimate-guide-verilog-test-bench/
* https://www.chipverify.com/verilog/verilog-testbench
* https://www.successbridge.co.in/verilog-modules-and-testbenches/
