`timescale 1ns/1ps

module strobe_tb;

    reg clk;
    reg reset;
    reg [3:0] select;
    wire led;
    wire col;

    strobe uut (
        .clk(clk),
        .reset(reset),
        .select(select),
        .led(led),
        .col(col)
    );

    initial clk = 0;
    initial reset = 0;
    initial select = 4'b0001;
    always #1 clk = ~clk;

    initial begin
        $dumpfile("strobe_tb.vcd");
        $dumpvars(0, strobe_tb);
        #1;
        reset = 1;
        #2;
        reset = 0;
        #50;
        select= 4'b0010;
        #100;
        select= 4'b1111;
        #100;
        
        $finish;
    end

endmodule