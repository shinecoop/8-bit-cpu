module alu #(parameter int WIDTH=8) (

    input [1:0] control,
    input [7:0] a,
    input [7:0] b,

    output logic [7:0] result,
    output logic cout,
    output logic [3:0] flags //VCNZ

);

// 8-bit ALU
//
// addition, subtration, AND, OR
//
logic carry;
logic [WIDTH:0] add, sub; //potential results of addition & subtraction
rcadder adder(.a(a), .b(b), .cin(0), .sum(add[WIDTH-1:0]), .cout(add[WIDTH]));
rcadder subber(.a(a), .b(~b+1), .cin(0), .sum(sub[WIDTH-1:0]), .cout(sub[WIDTH]));


always @(*) begin

    //determining result value with ripple-carry adder module
    case(control)
        2'b00: begin
            result = adder.sum;
            cout = add[WIDTH];
        end
        2'b01: begin
            result = subber.sum;
            cout = sub[WIDTH];
        end
        2'b10:
            result = a | b;
        2'b11:
            result = a & b;
    endcase

    //determining flags
    flags[0] = (~|result) ? 1 : 0; //zero
    flags[1] = (result[WIDTH-1] ) ? 1:0; //negative
    flags[2] = (cout) && ~control[1]; //carry

    //overflow flag
    flags[3] = ~(control[0] ^ a[WIDTH-1] ^ b[WIDTH-1]) && (a[WIDTH-1]^result[WIDTH-1]);
    flags[3] = flags[3] & ~control[1];



end



endmodule
