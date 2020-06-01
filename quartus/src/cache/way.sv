module way #(parameter tagsize = 9, parameter width = 128, parameter depth = 8)
(
    input clk,

    input logic [width-1:0] in,
    input logic [tagsize-1:0] tag,
    input [$clog2(depth)-1:0] index,
    input new_data, we,
    
    output [width-1:0] out,
    output [tagsize-1:0] tag_out,
    output logic valid, dirty
);

array #(.width(tagsize), .depth(depth)) tag_array
(
    .clk(clk),
    .index(index),
    .in(tag),
    .we(we & new_data),
    .out(tag_out)
);

array #(.width(1), .depth(depth)) valid_array
(
    .clk(clk),
    .index(index),
    .in(1'b1),
    .we(we & new_data),
    .out(valid)
);

array #(.width(1), .depth(depth)) dirty_array
(
    .clk(clk),
    .index(index),
    .in(~new_data),
    .we(we),
    .out(dirty)
);

array #(.width(width), .depth(depth)) data_array
(
    .clk(clk),
    .index(index),
    .in(in),
    .we(we),
    .out(out)
);

endmodule : way
