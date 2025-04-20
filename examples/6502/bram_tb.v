`timescale 1ns/1ps

module bram_tb();

    // Test on 8 bits
    reg clk;
    reg [1:0] addr;
    reg we;
    reg [7:0] data_in;
    wire [7:0] data;
    
    assign data = (we == 0) ? 8'bz : data_in;

    bram #(
        8,
        4,
        "sample.ram",
        2
    ) my_ram (
        clk,
        we,
        addr,
        data
    );

    initial clk = 0;
    initial data_in = 0;
    initial we = 0;
    initial addr = 0;
    always #1 clk = ~clk;

    initial begin
        $dumpfile("bram_tb.vcd");
        $dumpvars(0, bram_tb);
        #3;
        addr = 'h01;
        #2;
        data_in = 'hFF;
        we = 1;
        #2
        we = 0;
        addr = 'h02;
        #2
        addr = 'h01;
        #2
        $finish;
    end


endmodule
