module rcadder_tb();

    reg signed [7:0] a,b,sum;
    reg cin, cout;

    rcadder dut(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    reg clk = 0;
    always #1 clk=~clk;

    integer i, passcount, failcount;

    initial begin

        passcount=0;
        failcount=0;


        for(i=0; i<100; i=i+1) begin
            #1;
            a=$urandom;
            b=$urandom;
            cin=$random;

            #1;

            if(a+b+cin == {cout,sum})
                passcount=passcount+1;
            else
                failcount=failcount+1;

        end

        //check self-verification

        #1;
        if(failcount>0)
            $display("FAILED %d/%d RANDOM TESTS", failcount, 100);
        else
            $display("ALL %d RANDOM TESTS PASSED", 100);


        #1 $finish;


    end


    //dump for waveform analysis

    initial begin
        $dumpfile("./waveforms/rcadder_wf.vcd");
        $dumpvars(0, rcadder_tb);
    end

endmodule
