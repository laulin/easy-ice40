`timescale 1ns/1ps

module cpu6502_tb();

    reg clk;     
    reg reset;  
    wire [15:0] addr;
    reg [7:0] data_out;
    wire [7:0] data;
    wire rw ;
    reg [7:0] data_to_read;

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
        data_out = 'hAD;
    end

    assign data = (rw == 0) ? data_out : 8'bz;

    always #1 clk = ~clk;

    initial begin
        $dumpfile("cpu6502_tb.vcd");
        $dumpvars(0, cpu6502_tb);
        #3;
        reset=1;
        data_out = 'hAD;
        #2;
        data_out = 'h34;
        #2;
        data_out = 'h12;
        #2;
        
        #20;
        $finish;
    end




endmodule
