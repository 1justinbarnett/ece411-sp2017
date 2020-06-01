module array #(parameter width = 128, parameter depth = 8)
(
    input clk,

    input [$clog2(depth)-1:0] index,
    input [width-1:0] in,
    input we,

    output logic [width-1:0] out
);

logic [width-1:0] data [depth-1:0];

/* Initialize array */
initial
begin
    for (int i = 0; i < $size(data); i++)
    begin
        data[i] = 1'b0;
    end
end

always_ff @(posedge clk)
begin
    if (we == 1)
    begin
        data[index] = in;
    end
end

assign out = data[index];

endmodule : array
