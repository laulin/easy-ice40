`timescale 1ns/1ps

module debouncer_tb;


    reg clk;
    reg button;
    reg reset;
    wire[3:0] out_mode;

    debouncer uut (
        .clk(clk),
        .button(button),
        .reset(reset),
        .out_mode(out_mode)
    );

    initial clk = 0;
    initial button = 0;
    initial reset = 0;
    always #1 clk = ~clk;

    initial begin
        $dumpfile("debouncer_tb.vcd");
        $dumpvars(0, debouncer_tb);

        reset = 1;
        #5;
        reset = 0;
        #5;
        button = 1;
        #25; // 1
        button = 0;
        #5;

        button = 1;
        #20005; // 2
        button = 0;
        #5;

        button = 1;
        #20005; // 4
        button = 0;
        #5;

        button = 1;
        #20005; // 8
        button = 0;
        #5;

        button = 1;
        #20005; // 1
        button = 0;
        #5;

        //bounce
        button = 1;
        #500; 
        button = 0;
        #500;
        button = 1;
        #500; 
        button = 0;
        #500;
        button = 1;
        #21005; // 2
        button = 0;
        #5;


        $finish;
    end



endmodule