import lc3b_types::*;

module VictimCacheDatapath #(parameter linesize = 128)
(
    input clk,
    
    /* control inputs */
    input new_data, we, wdata_sel, wb, enableRandom,
    
    /* cpu inputs */
    input lc3b_word mem_address,
    input logic [linesize-1:0] mem_wdata,
    
    /* pmem inputs */
    input logic [linesize-1:0] pmem_rdata,
	input logic iDirty,
    
    /* control outputs */
    output logic dirty, hit,
    
    /* cpu outputs */
    output logic [linesize-1:0] mem_rdata,
    
    /* pmem outputs */
    output logic [linesize-1:0] pmem_wdata,
    output lc3b_word pmem_address
);

localparam sets = 1;
localparam WAYS = 8;
localparam WAYS_BITS = $clog2(WAYS);
localparam INDEX_BITS = $clog2(sets);
localparam OFFSET_BITS = $clog2(linesize / 8);
localparam TAG_BITS = 16 - INDEX_BITS - OFFSET_BITS;

typedef logic [linesize-1:0] l2_cache_line;
typedef logic [TAG_BITS-1:0] l2_cache_tag;

/* internal signals */
l2_cache_tag tag;
logic index;
logic [WAYS_BITS-1:0] _lru;
logic [WAYS_BITS-1:0] _hitWay;
l2_cache_tag tagmux_out;
l2_cache_line _WDataMuxOut;
l2_cache_line _out [WAYS-1:0];
l2_cache_tag _tagsOut[WAYS-1:0];
logic _dirty [WAYS-1:0];
logic _hit [WAYS-1:0];

assign tag = mem_address[15:15-TAG_BITS+1];
assign index = 0;

initial begin
	_lru = 0;
end

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
    logic _wayWe, _valid;
    assign _wayWe = (new_data & (_lru == i)) | (~new_data & _hit[i]);
    way1 #(.tagsize(TAG_BITS), .width(linesize), .depth(sets)) Way_
    (
        .clk(clk),
        .in(_WDataMuxOut),
		.dirty_in(iDirty),
        .tag(tag),
        .index(index),
        .we(_wayWe & we),
        .new_data(new_data),
        
        .out(_out[i]),
        .tag_out(_tagsOut[i]),
        .valid(_valid),
        .dirty(_dirty[i])
    );
    assign _hit[i] = (tag == _tagsOut[i]) & _valid;
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
 * Cache output
 */
assign dirty = _dirty[_lru];
assign hit = _hit.or;
assign mem_rdata = _out[_hitWay];
assign pmem_wdata = _out[_lru];

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
assign pmem_address = {tagmux_out, {OFFSET_BITS{1'b0}}};

always_ff @(posedge clk) begin
    if(enableRandom)
        _lru <= _lru + 1'b1;
end

endmodule : VictimCacheDatapath

module way1 #(parameter tagsize = 9, parameter width = 128, parameter depth = 8)
(
    input clk,

    input logic [width-1:0] in,
	input logic dirty_in,
    input logic [tagsize-1:0] tag,
    input index,
    input new_data, we,
    
    output [width-1:0] out,
    output [tagsize-1:0] tag_out,
    output logic valid, dirty
);

array1 #(.width(tagsize), .depth(depth)) tag_array
(
    .clk(clk),
    .index(index),
    .in(tag),
    .we(we & new_data),
    .out(tag_out)
);

array1 #(.width(1), .depth(depth)) valid_array
(
    .clk(clk),
    .index(index),
    .in(1'b1),
    .we(we & new_data),
    .out(valid)
);

array1 #(.width(1), .depth(depth)) dirty_array
(
    .clk(clk),
    .index(index),
    .in(dirty_in),
    .we(we),
    .out(dirty)
);

array1 #(.width(width), .depth(depth)) data_array
(
    .clk(clk),
    .index(index),
    .in(in),
    .we(we),
    .out(out)
);

endmodule : way1

module array1 #(parameter width = 128, parameter depth = 8)
(
    input clk,

    input index,
    input [width-1:0] in,
    input we,

    output logic [width-1:0] out
);

logic [width-1:0] data;

/* Initialize array */
initial
begin
    data = 1'b0;
end

always_ff @(posedge clk)
begin
    if (we == 1)
    begin
        data = in;
    end
end

assign out = data;

endmodule : array1
