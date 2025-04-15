module cpu6502 (
    input wire clk,         
    input wire reset,       //active low
    output reg [15:0] addr,
    inout [7:0] data,  
    output wire rw          
);

//states

localparam FETCH_OPCODE = 3'b000;
localparam READ_ADDR_LOW = 3'b001;
localparam READ_ADDR_HIGH = 3'b010;
localparam READ_DATA = 3'b011;
localparam EXECUTE = 3'b100;

reg [7:0] accumulator;
reg [15:0] pc;
reg [7:0] adl, adh;
reg [2:0] state;
reg [7:0] opcode;


assign rw = (state != EXECUTE) ? 1'b1 : 1'b0;
assign data = (rw) ? 8'bZZZZZZZZ : 8'h00;

always @(posedge clk or negedge reset) begin
    if (!reset) begin
        pc <= 16'h0000;
        state <= FETCH_OPCODE;
        accumulator <= 8'h00;
    end else begin
        case (state)
            // fetch
            FETCH_OPCODE: begin
                addr <= pc;
                opcode <= data;       
                pc <= pc + 1;
                state <= READ_ADDR_LOW;
            end

            // addr low (little endian)
            READ_ADDR_LOW: begin
                addr <= pc;
                adl <= data;         
                pc <= pc + 1;
                state <= READ_ADDR_HIGH;
            end

            // addr high
            READ_ADDR_HIGH: begin
                addr <= pc;
                adh <= data;
                pc <= pc + 1;
                state <= READ_DATA;
            end

            // read data
            READ_DATA: begin
                addr <= {adh, adl};   
                accumulator <= data; 
                state <= FETCH_OPCODE; 
            end

            default: state <= FETCH_OPCODE;
        endcase
    end
end


endmodule