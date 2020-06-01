import lc3b_types::*;

module ShiftRegisterArray #(parameter depth = 1024, parameter width = 4)
(
    input logic iClk,
    
    input logic iIn,
    input logic iWe,
    input logic[$clog2(depth) - 1: 0] iRIndex,
    input logic [$clog2(depth) - 1: 0] iWIndex,
    
    output logic[width - 1 : 0] oROut,
    output logic[width - 1 : 0] oWOut
);

logic [width - 1 : 0 ] data [depth-1:0];

/* Initialize array */
initial
begin
    for (int i = 0; i < $size(data); i++)
    begin
        data[i] = {width{1'b0}};
    end
end

assign oROut = data[iRIndex];
assign oWOut = data[iWIndex];

always_ff @(posedge iClk) begin
    if(iWe)
        data[iWIndex] <= {oWOut[width-2:0], iIn};
end

endmodule : ShiftRegisterArray
