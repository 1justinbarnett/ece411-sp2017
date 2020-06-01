import lc3b_types::*;

module DCache
(
    input clk,
    
    /* inputs from cpu */
    input lc3b_word mem_address, mem_wdata,
    input mem_read, mem_write,
    input lc3b_mem_wmask mem_byte_enable,
    
    /* inputs from memory */
    input cache_line pmem_rdata,
    input pmem_resp,
    
    /* outputs to cpu */
    output lc3b_word mem_rdata,
    output logic mem_resp,
	output logic oDirty,
    
    /* outputs to memory */
    output cache_line pmem_wdata,
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
logic valid;

assign oDirty = dirty;

DCacheControl control
(
    .*
);

DCacheDatapath datapath
(
    .*
);

endmodule : DCache
