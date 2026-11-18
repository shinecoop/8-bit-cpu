module riscvsingle #(ADDWIDTH=5) (

    input logic clk,
    output logic [ADDWIDTH:0] address,
    output logic [8:0] data

);

    //initialize PC
    logic regWrite, memWrite, resultSrc;
    logic[4:0] pc = 0; //FIX: make wider later?
    logic[31:0] instruction;
    logic[2:0] alucontrol;
    logic[7:0] w, r1, r2, aluResult, dataRead;

    logic carry;
    logic[3:0] flags;
    //MODULES


    //assign regWrite=1'b0;
    assign memWrite=1'b0;
    //instruction memory
    // recieves address (pc) and returns the instruction at that index

    im instmem (
	.a(pc),
	.r(instruction)
    );

    //control unit
    // accepts 31 bit instruction and returns the alu control associated

    controlUnit #(5) controlUnit (
	.instruction(instruction),
	.RegWrite(regWrite),
	.ResultSrc(resultSrc),
	.ALUControl (alucontrol)
    );

    //register file
    // accepts three addresses, write enable, and a write value
    // reads from ad1, 2 and writes to 3 if enabled

    regFile #(5) regfile (
	.clk(clk),
	.wena(regWrite),
	.ad3(instruction[7+ADDWIDTH-1:7]),
	.ad1(instruction[7+ADDWIDTH+3+5-1:7+ADDWIDTH+3]),
	.ad2(instruction[7+ADDWIDTH+3+5+5-1:7+ADDWIDTH+3+5]),
	.w  (resultSrc ? dataRead : aluResult),
	.r1 (r1),
	.r2 (r2)
    );

    //alu
    // takes read values from reg file and operates based on control

    alu #(8) alu (
	.control(alucontrol),
	.a      (r1),
	.b      (r2),
	.result (aluResult),
	.cout   (carry),
	.flags  (flags)
    );


    // data memory
    // alu computes read address, if enabled, writes value in register address 2

    dataMemory dataMemory (
	.clk        (clk),
	.ena        (memWrite),
	.address    (aluResult),
	.write_value(r2),
	.read_value (dataRead)
    );

    always @(posedge clk)begin
        pc <= pc+1;

    end









endmodule
