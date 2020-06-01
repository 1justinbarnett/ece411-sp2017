import lc3b_types::*;

module LruUnitAdv #(parameter depth = 32)
(
    input iClk,

    input logic [$clog2(depth)-1:0] iIndex,
    input logic [1:0] iIn,
    input logic iWe,
    
    output logic [1:0] oOut
);

logic [2:0] _arrayIn;
logic [2:0] _arrayOut;
logic _outMuxOut;

assign _arrayIn[2] = iIn[1];

Mux2 #(.width(1)) InMux0 (
    .sel(iIn[1]),
    .a(_arrayOut[0]),
    .b(iIn[0]),
    .f(_arrayIn[0])
);

Mux2 #(.width(1)) InMux1 (
    .sel(iIn[1]),
    .a(iIn[0]),
    .b(_arrayOut[1]),
    .f(_arrayIn[1])
);

array #(.width(3), .depth(depth)) LruArray (
    .clk(iClk),
    .index(iIndex),
    .in(_arrayIn),
    .we(iWe),
    .out(_arrayOut)
);

Mux2 #(.width(1)) OutMux (
    .sel(_arrayOut[2]),
    .a(_arrayOut[0]),
    .b(_arrayOut[1]),
    .f(_outMuxOut)
);

assign oOut = ~{_arrayOut[2], _outMuxOut};

endmodule : LruUnitAdv
