`timescale 1ns/1ps

module cpu6502_tb();

    reg clk;     
    reg reset;  
    wire [15:0] addr;
    wire [7:0] data;
    reg [7:0] data_drive;
    wire [7:0] data_recv;
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
    end

    assign data = data_drive;
    assign data_recv = data;

    always #1 clk = ~clk;

    initial begin
        $dumpfile("cpu6502_tb.vcd");
        $dumpvars(0, cpu6502_tb);
        #2 ;
        reset=1;
        data_drive = 'hAD;
        #2;
        data_drive = 'h34;
        #2
        data_drive = 'h12;
        #2 
        data_drive = 8'bZZZZZZZZ;

        #20;
        $finish;
    end




endmodule