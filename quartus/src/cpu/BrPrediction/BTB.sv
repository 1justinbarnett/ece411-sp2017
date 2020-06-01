import lc3b_types::*;

module BTB #(parameter linesize = 16, parameter sets = 32)
(
    input iClk,
    
    /* control inputs */
    input iWbBranch,
    
    /* cpu inputs */
    input lc3b_word iWPc,
    input lc3b_word iRPc,
    input lc3b_word iWbBranchAddr,
    
    /* control outputs */
    output logic oRHit,
    
    /* cpu outputs */
    output lc3b_word oBrAddr
);

localparam WAYS = 4;
localparam WAYS_BITS = $clog2(WAYS);
localparam INDEX_BITS = $clog2(sets);
localparam OFFSET_BITS = $clog2(linesize / 8);
localparam TAG_BITS = 16 - INDEX_BITS - OFFSET_BITS;

typedef logic [linesize-1:0] btb_line;
typedef logic [$clog2(sets)-1:0] btb_index;
typedef logic [TAG_BITS-1:0] btb_tag;

/* internal signals */
btb_tag _rTag, _wTag;
btb_index _rIndex, _wIndex;
logic [WAYS_BITS-1:0] _lru;
logic [WAYS_BITS-1:0] _rHitWay, _wHitWay;
btb_line _out [WAYS-1:0];
logic _rHitArray [WAYS-1:0], _wHitArray [WAYS-1:0];
logic _wHit;

assign _rTag = iRPc[15:15-TAG_BITS+1];
assign _rIndex = iRPc[OFFSET_BITS+INDEX_BITS-1:OFFSET_BITS];

assign _wTag = iWPc[15:15-TAG_BITS+1];
assign _wIndex = iWPc[OFFSET_BITS+INDEX_BITS-1:OFFSET_BITS];

/*
 * Ways
 */
generate
genvar i;
for(i = 0; i < WAYS; i++) begin : way_gen
    btb_tag _wayRTag, _wayWTag;
    logic _wayWe, _rValid, _wValid;
    assign _wayWe = ((iWbBranch & ~_wHit) & (_lru == i));
    BTBWay #(.tagsize(TAG_BITS), .depth(sets)) BTBWay_
    (
        .iClk(iClk),

        .iIn(iWbBranchAddr),
        .iTag(_wTag),
        .iRIndex(_rIndex),
        .iWIndex(_wIndex),
        .iWe(_wayWe),
        
        .oOut(_out[i]),
        .oRTag(_wayRTag), .oWTag(_wayWTag),
        .oRValid(_rValid), .oWValid(_wValid)
    );
    assign _rHitArray[i] = (_rTag == _wayRTag) & _rValid;
    assign _wHitArray[i] = (_wTag == _wayWTag) & _wValid;
end

always_comb begin : encoder
    int i;
    _rHitWay = 'x;
    _wHitWay = 'x;
    for(i = 0; i < WAYS; i++) begin
        if(_rHitArray[i] == 1'b1)
            _rHitWay = i[WAYS_BITS-1:0];
        if(_wHitArray[i] == 1'b1)
            _wHitWay = i[WAYS_BITS-1:0];
    end
end
endgenerate

/*
 * LRU
 */
LruUnitAdv #(.depth(sets)) LruUnit
(
    .iClk(iClk),
    .iIndex(_wIndex),
    .iIn(_wHitWay),
    .iWe(_wHit /*| iWbBranch*/),
    
    .oOut(_lru)
);

/*
 * Cache output
 */
assign _wHit = _wHitArray.or & iWbBranch;
assign oRHit = _rHitArray.or;
assign oBrAddr = _out[_rHitWay];

endmodule : BTB
