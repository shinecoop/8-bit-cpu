module controlUnit #(ADDWIDTH=5)(

    input logic [31:0] instruction,
    //output logic PCSrc, ResultSrc, ALUSrc, RegWrite, MemWrite,
    output logic RegWrite, ResultSrc,
    output logic [2:0] ALUControl//, ImmSrc

);

    //internal instruction logic
    logic [6:0] opcode, func7;
    logic [ADDWIDTH-1:0] rd, r1, r2;
    logic [2:0] func3;
    logic [11:0] imm;

    //parsing instruction
    assign opcode=instruction[6:0];
    assign rd = instruction[6+ADDWIDTH:7];
    assign func3 = instruction[6+ADDWIDTH+3: 6+ADDWIDTH+1];
    assign r1 = instruction[6+ADDWIDTH+3+ADDWIDTH: 6+ADDWIDTH+3+1];

    //for R type...
    assign r2 = instruction[6+ADDWIDTH+3+ADDWIDTH+ADDWIDTH: 6+ADDWIDTH+3+ADDWIDTH+1];
    assign func7 = instruction[31:6+ADDWIDTH+3+ADDWIDTH+ADDWIDTH+1 ];

    //for I type...
    assign imm = instruction[31:6+ADDWIDTH+3+ADDWIDTH+1];


    //ALUControl logic for add, sub, and, or functionality (R type)

    always @(*) begin

        RegWrite=1'b0;
        ResultSrc=1'b0;

        case(opcode)
            7'b0110011: begin //

                case(func7)
                    7'b0: begin //AND/OR/ADD

                        case(func3)

                            3'b000: begin //ADD
                                ALUControl=3'b000;
                                RegWrite=1'b1;
                            end

                            3'b110: begin //OR
                                ALUControl=3'b010;
                            end

                            3'b111: begin   //AND
                                ALUControl=3'b011;
                            end


                        default: ALUControl=3'bxx;

                        endcase

                    end

                    7'b0100000: begin //SUB
                        ALUControl=3'b001;
                    end

                    default: ALUControl=3'bxx;

                endcase

            end

            default begin
                ALUControl=3'bxx;
                RegWrite=1'b0;
                ResultSrc=1'b0; //default write alu result value

            end
        endcase

    end








endmodule
