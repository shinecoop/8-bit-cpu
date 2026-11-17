module dmtb();

    logic ena;
    logic [2:0] ad1, ad2, ad3;
    logic [7:0] write_value, read1, read2;

    logic clk=0;

    regFile dut (
	.clk(clk),
	.ad1(ad1),
	.ad2(ad2),
	.ad3(ad3),
	.w  (write_value),
	.r1 (read1),
	.r2 (read2)
    );



    integer i;
    always #1 clk=~clk;
    integer failcount;

    initial begin

        #1;
        failcount=0;

        for(i=0; i<10; i=i+1)begin

            @(negedge clk)
            ad1=$urandom;
            ad2=$urandom;
            ad3=$urandom;
            write_value=$urandom;

            @(negedge clk)



        end

        #1;

        if(failcount>0)
                $display("FAILED %d RANDOM TESTS", failcount);
            else
                $display("PASSED ALL RANDOM TESTS");

        $finish;

    end

    //dump to waveform

    initial begin
        $dumpfile("./waveforms/dmwf.vcd");
        $dumpvars(0,dmtb);
    end


endmodule
