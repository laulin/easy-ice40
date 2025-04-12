module blink (
    input clk12MHz,     
    output reg led1,    
    output lcol1        
);

    assign lcol1 = 1'b0;

    reg [21:0] counter;

    // just for test purpore, use reset otherwise
    initial begin
        counter = 21'b0;
    end

    always @(posedge clk12MHz) begin
        counter <= counter + 1;
        led1 <= counter[21]; 
    end

endmodule