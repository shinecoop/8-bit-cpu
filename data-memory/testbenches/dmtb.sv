module dmtb();

    logic ena;
    logic [7:0] write_value, read_value, address;

    logic clk=0;

    dataMemory dut (
    	.clk        (clk),
    	.ena        (ena),
    	.address    (address),
    	.write_value(write_value),
    	.read_value (read_value)
    );



    integer i;
    always #1 clk=~clk;
    integer failcount;

    initial begin

        #1;
        failcount=0;

        for(i=0; i<10; i=i+1)begin

            @(negedge clk)
            ena=1;
            address=$urandom;
            write_value=$urandom;

            @(negedge clk)
            ena=0;

            if(read_value!=write_value)
                failcount=failcount+1;


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
