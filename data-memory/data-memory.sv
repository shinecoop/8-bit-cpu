module dataMemory(

    input logic clk, ena, //clk and write enable
    input logic [7:0] address, write_value,
    output logic [7:0] read_value

    //sync writes, sync reads
);

    //create memory array (256x8)

    reg [7:0] mem [0:255];

    assign read_value = mem[address];

    always @(posedge clk)begin

        if(ena)
            mem[address] <= write_value;

    end



endmodule
