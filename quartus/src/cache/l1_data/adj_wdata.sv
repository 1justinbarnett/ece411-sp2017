import lc3b_types::*;

module adj_wdata
(
    input cache_line line,
    input cache_offset offset,
    input lc3b_word wdata,
    input lc3b_mem_wmask mem_byte_enable,
    
    output cache_line out
);

logic [2:0] off;

/* align offset */
assign off = offset[3:1];

always_comb
begin
    out = line;
    
    if(mem_byte_enable[1]) begin
        out[off][15:8] = wdata[15:8];
    end 
    
    if(mem_byte_enable[0]) begin
        out[off][7:0] = wdata[7:0];
    end
end

endmodule : adj_wdata
