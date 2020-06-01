import lc3b_types::*;
import lc3b_config::*;

module DCacheDatapath
(
    input clk,
    
    /* control inputs */
    input new_data, we, wdata_sel, wb,
    
    /* cpu inputs */
    input lc3b_word mem_address, mem_wdata,
    input lc3b_mem_wmask mem_byte_enable,
    
    /* pmem inputs */
    input cache_line pmem_rdata,
    
    /* control outputs */
    output logic dirty, hit, valid,
    
    /* cpu outputs */
    output lc3b_word mem_rdata,
    
    /* pmem outputs */
    output cache_line pmem_wdata,
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
cache_tag wbmux_out, tagmux_out;

/* signals for each way */
cache_tag tag0, tag1;
logic valid0, valid1;
logic dirty0, dirty1;
logic tag_equal0, tag_equal1;
logic hit0, hit1;
cache_line out0, out1;
cache_line adj_wdata_out0, adj_wdata_out1;
cache_line wdatamux_out0, wdatamux_out1;

assign tag = mem_address[15:7];
assign index = mem_address[6:4];
assign offset = mem_address[3:0];

/*
 * Way 0
 */
adj_wdata adj_wdata0
(
    .line(out0),
    .offset(offset),
    .wdata(mem_wdata),
    .mem_byte_enable(mem_byte_enable),
    
    .out(adj_wdata_out0)
);
 
Mux2 #(.width(128)) wdatamux0
(
    .sel(wdata_sel),
    .a(pmem_rdata),
    .b(adj_wdata_out0),
    
    .f(wdatamux_out0)
);

way way0
(
    .clk(clk),
    .in(wdatamux_out0),
    .tag(tag),
    .index(index),
    .we(we & ((mru & new_data) | (hit0 & ~new_data))),
    .new_data(new_data),
    
    .out(out0),
    .tag_out(tag0),
    .valid(valid0),
    .dirty(dirty0)
);

assign tag_equal0 = tag == tag0;
assign hit0 = tag_equal0 & valid0;

/*
 * Way 1
 */
adj_wdata adj_wdata1
(
    .line(out1),
    .offset(offset),
    .wdata(mem_wdata),
    .mem_byte_enable(mem_byte_enable),
    
    .out(adj_wdata_out1)
);
 
Mux2 #(.width(128)) wdatamux1
(
    .sel(wdata_sel),
    .a(pmem_rdata),
    .b(adj_wdata_out1),
    
    .f(wdatamux_out1)
);

way way1
(
    .clk(clk),
    .in(wdatamux_out1),
    .tag(tag),
    .index(index),
    .we(we & ((~mru & new_data) | (hit1 & ~new_data))),
    .new_data(new_data),
    
    .out(out1),
    .tag_out(tag1),
    .valid(valid1),
    .dirty(dirty1)
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
Mux2 #(.width(128)) pmem_wdatamux
(
    .sel(mru),
    .a(out1),
    .b(out0),
    
    .f(pmem_wdata)
);

Mux2 #(.width(128)) waymux
(
    .sel(hit1),
    .a(out0),
    .b(out1),
    
    .f(waymux_out)
);

assign mem_rdata = waymux_out[offset[3:1]];

assign hit = hit0 | hit1;
assign dirty = (dirty0 & mru) | (dirty1 & ~mru);

generate
if (USE_VICTIM_CACHES) begin
assign valid = (valid0 & mru) | (valid1 & ~mru);
end else begin
assign valid = dirty;
end
endgenerate

/*
 * Output address calculation
 */
Mux2 #(.width(9)) wbmux
(
    .sel(mru),
    .a(tag1),
    .b(tag0),
    
    .f(wbmux_out)
);

Mux2 #(.width(9)) tagmux
(
    .sel(wb),
    .a(tag),
    .b(wbmux_out),
    
    .f(tagmux_out)
);

/* Replace input tag with tag to be replaced and align to 8 words */
assign pmem_address = {tagmux_out, index, 4'h0};

endmodule : DCacheDatapath
