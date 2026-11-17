module im(

    input logic [4:0] a, //for 32 addresses
    output logic [31:0] r

);

    reg [31:0] mem [0:31]; //32 addresses, 32 bits long

    assign r = mem[a];


endmodule
