module top (
    input wire clk12MHz,
    input wire key1,
    output wire led1,
    output wire lcol1
);

    wire [3:0] select;
    wire reset = 0;

    debouncer d (
        clk12MHz,
        key1,
        reset,
        select
    );

    strobe s (
        clk12MHz,
        reset,
        select,
        led1,
        lcol1
    );


endmodule