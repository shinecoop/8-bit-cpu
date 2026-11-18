module im(

    input logic [4:0] a, //for 32 addresses
    output logic [31:0] r

);


    reg [31:0] mem [0:31]; //32 addresses, 32 bits long

    //read from instructions hex

    initial begin
        $readmemh("./instructions/1.hex", mem);

    end


    assign r = mem[a];


endmodule

module testbench();

    logic[4:0] pc=5'b0;
    logic[31:0] r;

    im dut (
    	.a(pc),
    	.r(r)
    );

    initial begin
        #1 pc++;
        #1 pc++;
        #1 pc++;
        #1 pc++;
        #1 pc++;
        #1 pc++;
        #1 $finish;
    end

    initial begin
        $dumpfile("./wave.vcd");
        $dumpvars(0, testbench);
    end


endmodule
