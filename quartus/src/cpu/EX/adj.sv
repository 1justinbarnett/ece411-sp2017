import lc3b_types::*;

/*
 * SEXT[offset-n << 1]
 */
module Adj #(parameter inWidth = 8, outWidth = 8)
(
    input logic [inWidth-1:0] in,
    output logic [outWidth - 1:0] out
);

assign out = $signed({in, 1'b0});

endmodule : Adj
