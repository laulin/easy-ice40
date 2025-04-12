`timescale 1ns/1ps

module blink_tb;
    reg clk12MHz;
    wire led1;
    wire lcol1;

    blink uut (
        .clk12MHz(clk12MHz),
        .led1(led1),
        .lcol1(lcol1)
    );

    initial begin
        clk12MHz = 0;
        forever #41.666 clk12MHz = ~clk12MHz; 
    end

    initial begin
        $dumpfile("blink_tb.vcd");
        $dumpvars(0, blink_tb);
        #500000000; 
        $finish;
    end
endmodule
