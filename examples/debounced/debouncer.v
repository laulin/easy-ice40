module debouncer (
    input wire clk,
    input wire button,
    input wire reset,
    output reg [3:0] out_mode
);

    reg [16:0] counter;
    reg [1:0] mode;
    reg locked;

    always @(posedge clk) begin
        if (reset) begin
            mode <= 0;
            locked <= 0;
        end else begin
            if (!button) begin 
                counter <= 0;
                locked <= 0;
            end else begin 
                if (!locked) begin
                    counter <= counter +1;
                    if (counter > 10000) begin
                        mode <= mode +1;
                        locked <= 1;
                    end
                end
            end
        end

        out_mode <= 1<<mode;
    end

endmodule