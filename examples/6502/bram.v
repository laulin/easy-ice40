// direcly inspired by https://github.com/projf/projf-explore/blob/main/lib/memory/bram_sdp.sv
// converted to verilog. Thanks Will !

module bram #(
    parameter WIDTH=8, 
    parameter DEPTH=256, 
    parameter INIT_F="",
    parameter ADDRW=$clog2(DEPTH)
    ) (
    input wire clk,               
    input wire we,                      
    input wire [ADDRW-1:0] addr,  
    inout wire [WIDTH-1:0] data
    );

    reg [WIDTH-1:0] memory [DEPTH-1:0];
    reg [WIDTH-1:0] data_reg; 

    // we == 0 means read
    assign data = (we == 0) ? data_reg : 8'bz;

    initial begin
        if (INIT_F != 0) begin
            $display("Load init file '%s' into bram.", INIT_F);
            $readmemh(INIT_F, memory);
        end
    end

    always @(posedge clk) begin
        if(we == 0) begin
            data_reg <= memory[addr];
        end else begin
            memory[addr] <= data;
        end
    end
endmodule
