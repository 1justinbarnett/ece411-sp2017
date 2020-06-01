import lc3b_types::*;
import lc3b_config::*;

module L2Cache #(parameter linesize = 128, parameter sets = 32)
(
    input clk,
    
    /* inputs from cpu */
    input lc3b_word mem_address,
    input logic [linesize-1:0] mem_wdata,
    input mem_read, mem_write,
    
    /* inputs from memory */
    input logic [linesize-1:0] pmem_rdata,
    input pmem_resp,
    
    /* outputs to cpu */
    output logic [linesize-1:0] mem_rdata,
    output logic mem_resp,
    
    /* outputs to memory */
    output logic [linesize-1:0] pmem_wdata,
    output lc3b_word pmem_address,
    output logic pmem_read, pmem_write
);

/* internal signals */
logic dirty;
logic hit;
logic new_data;
logic we;
logic wdata_sel;
logic wb;

generate
if(USE_ADVANCED_CACHE) begin
    L2CacheControlAdv control(.*);
    L2CacheDatapathAdv #(.linesize(linesize), .sets(sets)) datapath(.*);
end else begin
    L2CacheControl control(.*);
    L2CacheDatapath #(.linesize(linesize), .sets(sets)) datapath(.*);
end
endgenerate

endmodule : L2Cache
