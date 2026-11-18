module cputb();

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

        #20

        $finish;

    end



    initial begin
        //dump for vcd
        $dumpfile("./waveforms/cpuwf.vcd");
        $dumpvars(0,cputb);

    end



endmodule
