module regFile #(ADDWIDTH=5)(
    input logic clk, wena,
    input logic [ADDWIDTH-1:0] ad1,ad2,ad3,
    input logic [7:0] w,
    output logic [7:0] r1,r2

);


    reg [7:0] mem[0:31];

    //TEMPORARY
    integer i;
    initial begin
        for(i=0; i<20; i++)begin
            mem[i] = 8'b1;
        end

    end


    assign r1=mem[ad1];
    assign r2=mem[ad2];



    always @(posedge clk )begin

        mem[ad3] <= (wena)?w:mem[ad3];
    end


endmodule
