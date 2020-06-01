import lc3b_types::*;

module BTBWay #(parameter tagsize = 9, parameter depth = 8)
(
    input iClk,

    input lc3b_word iIn,
    input logic [tagsize-1:0] iTag,
    input logic [$clog2(depth)-1:0] iRIndex,
    input logic [$clog2(depth)-1:0] iWIndex,
    input logic iWe,
    
    output lc3b_word oOut,
    output [tagsize-1:0] oRTag, oWTag,
    output logic oRValid, oWValid
);

DualPortArray #(.width(tagsize), .depth(depth)) TagArray
(
    .iClk(iClk),

    .iRIndex(iRIndex),
    .iWIndex(iWIndex),
    .iWIn(iTag),
    .iWe(iWe),

    .oROut(oRTag),
    .oWOut(oWTag)
);

DualPortArray #(.width(1), .depth(depth)) ValidArray
(
    .iClk(iClk),

    .iRIndex(iRIndex),
    .iWIndex(iWIndex),
    .iWIn(1'b1),
    .iWe(iWe),

    .oROut(oRValid),
    .oWOut(oWValid)
);

DualPortArray #(.width(16), .depth(depth)) DataArray
(
    .iClk(iClk),

    .iRIndex(iRIndex),
    .iWIndex(iWIndex),
    .iWIn(iIn),
    .iWe(iWe),

    .oROut(oOut),
    .oWOut()
);

endmodule : BTBWay