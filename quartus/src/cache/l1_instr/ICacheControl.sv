module ICacheControl
(
    input clk,
    
    /* inputs external to cache */
    input mem_read, pmem_resp,
    
    /* inputs internal to cache */
    input hit,
    
    /* outputs external to cache */
    output logic mem_resp, pmem_read,
    
    /* outputs internal to cache */
    output logic we
);

enum int unsigned {
    idle,
    allocate1, allocate2
} state, next_state;

always_comb
begin : outputs
    mem_resp = 1'b0;
    pmem_read = 1'b0;
    we = 1'b0;
    
    case(state)
        idle: begin
            if(hit & mem_read)
                mem_resp = 1'b1;
        end
        
        allocate1: begin
            pmem_read = 1'b1;
        end
        
        allocate2: begin
            we = 1'b1;
        end
        
        default: ;
    endcase
end

always_comb
begin : next_state_logic
    next_state = idle;
    
    case(state)
        idle: begin
            if(mem_read & ~hit)
                next_state = allocate1;
        end
        
        allocate1: begin
            if(~pmem_resp)
                next_state = allocate1;
            else
                next_state = allocate2;
        end
        
        allocate2: begin
            next_state = idle;
        end
        
        default: ;
    endcase
end

always_ff @ (posedge clk)
begin : next_state_assignment
    state <= next_state;
end

endmodule : ICacheControl
