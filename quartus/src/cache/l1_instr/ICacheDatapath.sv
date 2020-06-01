import lc3b_types::*;

module ICacheDatapath
(
    input clk,
    
    /* control inputs */
    input we,
    
    /* cpu inputs */
    input lc3b_word mem_address,
    
    /* pmem inputs */
    input cache_line pmem_rdata,
    
    /* control outputs */
    output logic hit,
    
    /* cpu outputs */
    output lc3b_word mem_rdata,
    
    /* pmem outputs */
    output lc3b_word pmem_address
);

/* internal signals */
cache_tag tag;
cache_index index;
cache_offset offset;
logic mru;
logic lrumux_out;
cache_line waymux_out;
lc3b_word offsetmux_out;

/* signals for each way */
cache_tag tag0, tag1;
logic valid0, valid1;
logic tag_equal0, tag_equal1;
logic hit0, hit1;
cache_line out0, out1;

assign tag = mem_address[15:7];
assign index = mem_address[6:4];
assign offset = mem_address[3:0];

/*
 * Way 0
 */
way way0
(
    .clk(clk),
    .in(pmem_rdata),
    .tag(tag),
    .index(index),
    .we(we & mru),
    .new_data(1'b1),
    
    .out(out0),
    .tag_out(tag0),
    .valid(valid0),
    .dirty()
);

assign tag_equal0 = tag == tag0;
assign hit0 = tag_equal0 & valid0;

/*
 * Way 1
 */
way way1
(
    .clk(clk),
    .in(pmem_rdata),
    .tag(tag),
    .index(index),
    .we(we & ~mru),
    .new_data(1'b1),
    
    .out(out1),
    .tag_out(tag1),
    .valid(valid1),
    .dirty()
);

assign tag_equal1 = tag == tag1;
assign hit1 = tag_equal1 & valid1;

/*
 * LRU
 */
Mux2 #(.width(1)) lrumux
(
    .sel(hit1),
    .a(1'b0),
    .b(1'b1),
    
    .f(lrumux_out)
);

array #(.width(1)) lru_array
(
    .clk(clk),
    .index(index),
    .in(lrumux_out),
    .we(hit),
    
    .out(mru)
);

/*
 * Cache output
 */
Mux2 #(.width(128)) waymux
(
    .sel(hit1),
    .a(out0),
    .b(out1),
    
    .f(waymux_out)
);

assign mem_rdata = waymux_out[offset[3:1]];

assign hit = hit0 | hit1;

/*
 * Output address calculation
 */
assign pmem_address = {tag, index, 4'h0};

endmodule : ICacheDatapath
