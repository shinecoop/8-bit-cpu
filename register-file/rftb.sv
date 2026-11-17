module rftb();

    logic [7:0] w, r1, r2;
    logic [2:0] ad1, ad2, ad3;

    logic clk = 1'b0;

    regFile dut (
    	.clk(clk),
    	.ad1(ad1),
    	.ad2(ad2),
    	.ad3(ad3),
    	.w  (w),
    	.r1 (r1),
    	.r2 (r2)
    );


    always #1 clk = ~clk;

    integer failcount=0;
    logic [7:0] addy;

    initial begin
        //testing

        //random value writing to addresses
        for(int i=0; i<20; i++)begin
            ad3 = $urandom;
            w = $urandom;
            #1;
        end

        //reading assigning ad1 and ad2 to the same address to test reading;

        for(int i=0; i<20; i++)begin

            addy = $urandom;

            ad1=addy;
            ad2=addy;

            #1;
            if(r1!=r2)
                failcount++;

        end


        $finish;


    end

    initial begin
        //dump for vcd
        $dumpfile("./waveforms/rfwf.vcd");
        $dumpvars(0,rftb);

    end



endmodule
