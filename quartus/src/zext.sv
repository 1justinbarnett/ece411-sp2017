module Zext #(parameter width = 16) (
    input logic[width-1:0] in,
    output logic[width-1:0] out
);

assign out = $signed({1'b0, in});

endmodule:Zext
