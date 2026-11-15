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

    initial begin

        #1;

        for(i=0; i<10; i=i+1)begin

            @(negedge clk)
            ena=$urandom;
            address=$urandom;
            write_value=$urandom;

            @(negedge clk)
            ena=$urandom;
            write_value=$urandom;


        end

        #1;

        $finish;

    end

    //dump to waveform

    initial begin
        $dumpfile("./waveforms/dmwf.vcd");
        $dumpvars(0,dmtb);
    end


endmodule
