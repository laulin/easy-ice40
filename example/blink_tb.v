`timescale 1ns/1ps

module blink_tb;
    reg clk12MHz;
    wire led1;
    wire lcol1;

    // Instanciation du module blink
    blink uut (
        .clk12MHz(clk12MHz),
        .led1(led1),
        .lcol1(lcol1)
    );

    // Génération de l'horloge 12 MHz
    initial begin
        clk12MHz = 0;
        forever #41.666 clk12MHz = ~clk12MHz; // Période de 83.333 ns pour 12 MHz
    end

    // Surveillance des signaux
    initial begin
        $dumpfile("blink_tb.vcd");
        $dumpvars(0, blink_tb);
        #500000000; // Durée de simulation : 500 ms
        $finish;
    end
endmodule
