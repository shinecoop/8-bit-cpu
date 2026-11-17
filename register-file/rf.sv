module regFile(
    input logic clk,
    input logic [2:0] ad1,ad2,ad3,
    input logic [7:0] w,
    output logic [7:0] r1,r2

);

    reg [7:0] mem[0:7];

    assign r1=mem[ad1];
    assign r2=mem[ad2];

    always @(posedge clk)begin
        mem[ad3] <=w;
    end


endmodule
