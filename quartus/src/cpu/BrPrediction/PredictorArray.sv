module PredictorArray #( parameter depth = 1024 )
(
    input clk,

    input [$clog2(depth)-1:0] iRIndex,
    input [$clog2(depth)-1:0] iWIndex,
    input [1:0] in,
    input we,

    output logic oROut,
    output logic [1:0] oWOut
);

logic [1:0] data [depth-1:0];

/* Initialize array */
initial
begin
    for (int i = 0; i < $size(data); i++)
    begin
        data[i] = 2'b01;
    end
end

always_ff @(posedge clk)
begin
    if (we == 1)
    begin
        data[iWIndex] = in;
    end
end

assign oROut = data[iRIndex][1];
assign oWOut = data[iWIndex];

endmodule : PredictorArray