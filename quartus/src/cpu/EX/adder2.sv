module Adder2 #(parameter width = 16) (
    input [width - 1:0] a, b,
    output [width-1:0] f
);

assign f = a + b;

endmodule : Adder2
