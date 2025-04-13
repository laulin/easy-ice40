module strobe(
    input wire clk,
    input wire reset,
    input wire[3:0] select,
    output reg led,
    output wire col
);

    assign col = 0; // this pin is used on icefun to enable colon
    reg [23:0] counter;
    reg [23:0] threshold;

    always @ (posedge clk) begin
        if (reset) begin
            led <= 0;
            counter <=0 ;
            threshold <= 0;
        end else begin
            

            case (select)
                4'b0001: threshold <= 10;
                4'b0010: threshold <= 15;
                4'b0100: threshold <= 20;
                4'b1000: threshold <= 25;
                default: threshold <= 0;
            endcase

            if (threshold == 0) begin // if mode is not invalid
                led <= 0;
                counter <= 0;
            end else begin
                counter <= counter + 1;
                if (counter >= threshold) begin
                    counter <=0 ;
                    led = ~ led;
                end
            end


        end
    end
endmodule