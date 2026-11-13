module rcadder #(parameter int WIDTH=8)(

    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    input cin,

    output logic signed [WIDTH-1:0] sum,
    output logic cout

);

    //carry-bit vector for full adder assignment
    wire  carry[WIDTH:0];
    assign carry[0]=cin;

    //generate instances of fulladder to compute 8 bits
    genvar i;

    generate
        for (i=0; i<WIDTH; i=i+1) begin: fa_instances
            fulladder fa (.a(a[i]), .b(b[i]), .cin(carry[i]), .sum(sum[i]), .cout(carry[i+1]));
        end
    endgenerate

    //assign cout to final value of temporary carry
    assign cout = carry[WIDTH];

endmodule

module fulladder(
    input a,b,cin,
    output logic sum, cout
);

    assign sum = a^b^cin;
    assign cout = (a&b) | cin&(a^b);

endmodule
