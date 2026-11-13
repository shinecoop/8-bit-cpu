module alu_tb();

  reg signed [7:0] a, b, result;
  reg [1:0] control;
  reg [3:0] flags;
  reg cout;

  alu dut(.a(a),.b(b),.control(control), .result(result), .flags(flags), .cout(cout));

  reg clk = 1'b0;
  always #1 clk = ~clk;

  integer i, failcount,flagcount;

  initial begin
      #1;
      failcount=0;
      flagcount=0;

      for(i=0; i<100; i=i+1)begin

          //random assignment of inputs
          a = $urandom;
          b = $urandom;
          control = $urandom;

          //self-verification
          #1;

        case(control)
            2'b00: failcount = failcount+(dut.result !== (a+b));
            2'b01: failcount = failcount+(dut.result !== (a-b));
            2'b10: failcount = failcount+(dut.result !== (a|b));
            2'b11: failcount = failcount+(dut.result !== (a&b));
        endcase

        //flag verification
        if(((result==0)^flags[0])) flagcount = flagcount+1; //z

        if ((result<0)^flags[1]) flagcount=flagcount+1; // n

        if ((cout && ~control[1]) ^ flags[2]) flagcount=flagcount+1; //c

        if (((~(control[0]^a[7]^b[7])) && (a[7]^result[7]) && (~control[1])) ^ flags[3]) flagcount=flagcount+1; //v



      end

      //display

    if(failcount>0 || flagcount >0)
        $display("FAILED %d RANDOM TESTS ... FAILED %d FLAGS", failcount, flagcount);
    else
        $display("PASSED ALL RANDOM TESTS");

    #1 $finish;




  end

  //dumpfile for waveform

  initial begin
      $dumpfile("./waveforms/alu_wf.vcd");
      $dumpvars(0,alu_tb);
  end


endmodule
