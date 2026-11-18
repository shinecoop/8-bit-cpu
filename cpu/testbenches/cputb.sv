module cputb();



    //RISC-V instructions
    logic[31:0] add = 32'b0000000_00000_00000_000_00000_0110011;
    logic[31:0] sub = 32'b0100000_00000_00000_000_00000_0110011;
    logic[31:0] andd = 32'b0000000_00000_00000_111_00000_0110011;
    logic[31:0] orr = 32'b0000000_00000_00000_110_00000_0110011;

    logic clk=0;
    always #1 clk=~clk;

    logic[4:0] address, pc;//TEMP;
    logic[7:0] data;

    riscvsingle #(5) dut (
	.clk    (clk),
	.address(address),
	.data   (data)
    );


    initial begin

        #5

        $finish;

    end



    initial begin
        //dump for vcd
        $dumpfile("./waveforms/cpuwf.vcd");
        $dumpvars(0,cputb);

    end



endmodule
