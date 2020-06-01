import lc3b_types::*;

module ICache
(
    input clk,
    
    /* inputs from cpu */
    input lc3b_word mem_address,
    input mem_read,
    
    /* inputs from memory */
    input cache_line pmem_rdata,
    input pmem_resp,
    
    /* outputs to cpu */
    output lc3b_word mem_rdata,
    output logic mem_resp,
    
    /* outputs to memory */
    output lc3b_word pmem_address,
    output logic pmem_read
);

/* internal signals */
logic hit;
logic we;
logic valid;
logic wb;

ICacheControl control
(
    .*
);

ICacheDatapath datapath
(
    .*
);

endmodule : ICache
