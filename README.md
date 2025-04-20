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

A full working examples are available `in examples/`. 

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

To use the example (after installation), go to the `examples/blink` directory and run `sudo easy-ice40`. The current directory is mounted in `/work`. Plug you board and run `make`. If everything is **OK**, a led should blink. Congratulation !

To test the source code, you can run `make test`. After some second, GTKwave should appear; Add wave and you will see traces.

## Cookbook

### tri-state

This isn't exactly intuitive. You need three signals :

- an inout module argument, for exemple a data from/to a cpu of a ram
- an rw wire, used to control the befaviour. It can be an input (ex : ram) or an output (ex : cpu)
- an internal register used to writing ops

Let's take an example :

```verilog
module bram_256 (
    input wire clk,               
    input wire we,                      
    input wire [7:0] addr,  
    inout wire [7:0] data
    );

    reg [7:0] data_reg; 
    reg [7:0] memory [7:0];

    // we == 0 means read
    assign data = (we == 0) ? data_reg : 8'bz;

    always @(posedge clk) begin
        if(we == 0) begin
            data_reg <= memory[addr];
        end else begin
            memory[addr] <= data;
        end
    end
endmodule
```

if *we* (input) is clear, it means the ram need to output byte in data_reg stored at *addr*. If *we* is set, the wire bus is set as *z* which means high impedance. In this case, data can be read and the result is stored in the ram.

For the testbench, it is the opposite (we = 0 means high impedance and read, we = 1 means write).

### Module with parameters

https://logicmadness.com/verilog-parameters/

## useful link
### benchmark
* https://hardwarebee.com/ultimate-guide-verilog-test-bench/
* https://www.chipverify.com/verilog/verilog-testbench
* https://www.successbridge.co.in/verilog-modules-and-testbenches/

### general purpose
* https://www.fpga4fun.com/
* https://nandland.com/
* cheatsheet : https://marceluda.github.io/rp_dummy/EEOF2018/Verilog_Cheat_Sheet.pdf
* https://www.chipverify.com/verilog/
* https://semiconshorts.com/2024/04/07/verilog-constants/
* https://www.fpga4student.com/
* https://electronics.stackexchange.com/questions/556859/verilog-testbench-for-inout
* https://z80.ro/post/using_pll/
* https://projectf.io/posts/fpga-graphics/
