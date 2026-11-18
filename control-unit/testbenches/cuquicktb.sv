module cutb();

    logic[31:0] instruction;
    logic[1:0] ALUControl;

    logic[7:0] a,b,result;
    logic cout;
    logic [3:0] flags;

    //RISC-V instructions
    logic[31:0] add = 31'b0000000_00000_00000_000_00000_0110011;
    logic[31:0] sub = 31'b0100000_00000_00000_000_00000_0110011;
    logic[31:0] andd = 31'b0000000_00000_00000_111_00000_0110011;
    logic[31:0] orr = 31'b0000000_00000_00000_110_00000_0110011;




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
        instruction=add; //ADD

        //alucontrol should update, updating result

        #1
        instruction=sub; //sub

        #1
        instruction=andd; //and

        #1
        instruction=orr; //or

        #1

        $finish;


    end

    initial begin
        //dump for vcd
        $dumpfile("./waveforms/cuwf.vcd");
        $dumpvars(0,cutb);

    end



endmodule
