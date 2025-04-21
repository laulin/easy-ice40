`timescale 1ns/1ps

module cpu6502_tb();

    reg clk;     
    reg reset;  
    wire [15:0] addr;
    reg [7:0] data_out;
    wire [7:0] data;
    wire rw ;

    cpu6502 cpu (
        clk,
        reset,
        addr,
        data,
        rw
    );

    initial begin
        reset = 0;
        clk = 0;
    end

    assign data = (rw == 1) ? data_out : 8'bz;

    always #1 clk = ~clk;

    initial begin
        $dumpfile("cpu6502_tb.vcd");
        $dumpvars(0, cpu6502_tb);
        #2;
        reset=1;
        data_out = 'hAD;
        #3;
        data_out = 'h34;
        #2;
        data_out = 'h12;
        #2;
        data_out = 'hAA;
        #2
        
        $finish;
    end




endmodule
