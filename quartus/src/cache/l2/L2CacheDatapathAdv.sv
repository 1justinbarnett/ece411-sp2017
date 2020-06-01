import lc3b_types::*;

module L2CacheDatapathAdv #(parameter linesize = 128, parameter sets = 32)
(
    input clk,
    
    /* control inputs */
    input new_data, we, wdata_sel, wb,
    
    /* cpu inputs */
    input lc3b_word mem_address,
    input logic [linesize-1:0] mem_wdata,
    
    /* pmem inputs */
    input logic [linesize-1:0] pmem_rdata,
    
    /* control outputs */
    output logic dirty, hit,
    
    /* cpu outputs */
    output logic [linesize-1:0] mem_rdata,
    
    /* pmem outputs */
    output logic [linesize-1:0] pmem_wdata,
    output lc3b_word pmem_address
);

localparam WAYS = 4;
localparam WAYS_BITS = $clog2(WAYS);
localparam INDEX_BITS = $clog2(sets);
localparam OFFSET_BITS = $clog2(linesize / 8);
localparam TAG_BITS = 16 - INDEX_BITS - OFFSET_BITS;

typedef logic [linesize-1:0] l2_cache_line;
typedef logic [$clog2(sets)-1:0] l2_cache_index;
typedef logic [TAG_BITS-1:0] l2_cache_tag;

/* internal signals */
l2_cache_tag tag;
l2_cache_index index;
logic [WAYS_BITS-1:0] _lru;
logic [WAYS_BITS-1:0] _hitWay;
l2_cache_tag tagmux_out;
l2_cache_line _WDataMuxOut;
l2_cache_line _out [WAYS-1:0];
l2_cache_tag _tagsOut[WAYS-1:0];
logic _dirty [WAYS-1:0];
logic _hit [WAYS-1:0];

assign tag = mem_address[15:15-TAG_BITS+1];
assign index = mem_address[OFFSET_BITS+INDEX_BITS-1:OFFSET_BITS];

/*
 * Input data muxing
 */
Mux2 #(.width(linesize)) WDataMux
(
    .sel(wdata_sel),
    .a(pmem_rdata),
    .b(mem_wdata),
    
    .f(_WDataMuxOut)
);

/*
 * Ways
 */
generate
genvar i;
for(i = 0; i < WAYS; i++) begin : way_gen
    l2_cache_line _wayOut;
    logic _wayWe, _valid;
    assign _wayWe = (new_data & (_lru == i)) | (~new_data & _hit[i]);
    way #(.tagsize(TAG_BITS), .width(linesize), .depth(sets)) Way_
    (
        .clk(clk),
        .in(_WDataMuxOut),
        .tag(tag),
        .index(index),
        .we(_wayWe & we),
        .new_data(new_data),
        
        .out(_wayOut),
        .tag_out(_tagsOut[i]),
        .valid(_valid),
        .dirty(_dirty[i])
    );
    assign _hit[i] = (tag == _tagsOut[i]) & _valid;
    always_ff @ (posedge clk) _out[i] <= _wayOut;
end

always_comb begin : encoder
    int i;
    _hitWay = 'x;
    for(i = 0; i < WAYS; i++)
        if(_hit[i] == 1'b1)
            _hitWay = i[WAYS_BITS-1:0];
end
endgenerate

/*
 * LRU
 */
LruUnitAdv #(.depth(sets)) LruUnit
(
    .iClk(clk),
    .iIndex(index),
    .iIn(_hitWay),
    .iWe(hit),
    
    .oOut(_lru)
);

/*
 * Cache output
 */
assign dirty = _dirty[_lru];
assign hit = _hit.or;
assign mem_rdata = _out[_hitWay];
always_ff @ (posedge clk) pmem_wdata <= _out[_lru];

/*
 * Output address calculation
 */
Mux2 #(.width(TAG_BITS)) TagMux
(
    .sel(wb),
    .a(tag),
    .b(_tagsOut[_lru]),
    
    .f(tagmux_out)
);

/* Replace input tag with tag to be replaced and align to 8 words */
always_ff @ (posedge clk) pmem_address <= {tagmux_out, index, {OFFSET_BITS{1'b0}}};

endmodule : L2CacheDatapathAdv
