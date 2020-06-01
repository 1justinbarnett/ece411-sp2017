module DualPortArray #( parameter depth = 32, parameter width = 8 )
(
    input iClk,

    input [$clog2(depth)-1:0] iRIndex,
    input [$clog2(depth)-1:0] iWIndex,
    input [width-1:0] iWIn,
    input iWe,

    output logic [width-1:0] oROut,
    output logic [width-1:0] oWOut
);

logic [width-1:0] data [depth-1:0];

/* Initialize array */
initial
begin
    for (int i = 0; i < $size(data); i++)
    begin
        data[i] = {width{1'b0}};
    end
end

always_ff @(posedge iClk)
begin
    if (iWe == 1)
    begin
        data[iWIndex] = iWIn;
    end
end

assign oROut = data[iRIndex];
assign oWOut = data[iWIndex];

endmodule : DualPortArray