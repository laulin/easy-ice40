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
reg [7:0] adl;
reg [7:0] adh;
reg [2:0] state;
reg [7:0] opcode;

// used to manage tri stage data bus
// On rw == 1, data is in high impedance
// On rw == 0, data copies data_reg
reg rw_reg;
reg [7:0] data_reg;

assign rw = rw_reg;
assign data = (rw == 0) ? data_reg : 8'bz;

always @(posedge clk) begin
    if (!reset) begin
        pc <= 16'h0000;
        state <= FETCH_OPCODE;
        accumulator <= 8'h00;
        rw_reg <= 1;
        data_reg <= 8'h00;
        adl <=  8'h00;
        adh <=  8'h00;
        opcode <=  8'h00;
        addr  <=  8'h00;
    end else begin
        case (state)
            // fetch
            FETCH_OPCODE: begin
                rw_reg <= 1;
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
