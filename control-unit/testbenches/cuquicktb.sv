module cutb();

    logic[31:0] instruction;
    logic[1:0] ALUControl;

    logic[7:0] a,b,result;
    logic cout;
    logic [3:0] flags;


    controlUnit #(
    	.ADDWIDTH(5)
     ) dut (
    	.instruction(instruction),
    	.ALUControl (ALUControl)
    );

    alu #(
	.WIDTH(8)
     ) alu (
	.control(ALUControl),
	.a      (a),
	.b      (b),
	.result (result),
	.cout   (cout),
	.flags  (flags)
    );

    logic clk=0;

    always #1 clk=~clk;

    initial begin
        a=8'b00000001;
        b=8'b00000001;

        #1
        instruction=31'b0000000_00000_00000_000_00000_0110011; //ADD

        //alucontrol should update, updating result

        #1
        instruction=31'b0100000_00000_00000_000_00000_0110011; //sub

        #1
        instruction=31'b0000000_00000_00000_111_00000_0110011; //and

        #1
        instruction=31'b0000000_00000_00000_110_00000_0110011; //or

        #1

        $finish;


    end

    initial begin
        //dump for vcd
        $dumpfile("./waveforms/cuwf.vcd");
        $dumpvars(0,cutb);

    end



endmodule
