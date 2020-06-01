module VictimCacheControl
(
    input clk,
    
    /* inputs external to cache */
    input mem_read, mem_write, pmem_resp,
    
    /* inputs internal to cache */
    input dirty, hit,
    
    /* outputs external to cache */
    output logic mem_resp, pmem_read, pmem_write,
    
    /* outputs internal to cache */
    output logic new_data, we, wdata_sel, wb, enableRandom
);

enum int unsigned {
    idle,
    allocate1, allocate2,
    write_back
} state, next_state;

always_comb
begin : outputs
    mem_resp = 1'b0;
    pmem_read = 1'b0;
    pmem_write = 1'b0;
    new_data = 1'b0;
    we = 1'b0;
    wdata_sel = 1'b0;
    wb = 1'b0;
    enableRandom = 1'b0;
    
    case(state)
        idle: begin
            wdata_sel = 1'b1;
            
            //if(~mem_read & ~mem_write)
            //    enableRandom = 1'b1;
            
            if(hit) begin
                if(mem_read | mem_write)
                    mem_resp = 1'b1;
                
                if(mem_write)
                    we = 1'b1;
            end
        end
        
        allocate1: begin
            pmem_read = 1'b1;
        end
        
        allocate2: begin
            new_data = 1'b1;
            we = 1'b1;
            enableRandom = 1'b1;
        end
        
        write_back: begin
            pmem_write = 1'b1;
            wb = 1'b1;
        end
        
        default: ;
    endcase
end

always_comb
begin : next_state_logic
    next_state = idle;
    
    case(state)
        idle: begin
            if((mem_read | mem_write) & ~hit) begin
                if(dirty)
                    next_state = write_back;
                else if(~dirty)
                    next_state = allocate1;
            end
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
        
        write_back: begin
            if(~pmem_resp)
                next_state = write_back;
            else
                next_state = allocate1;
        end
        
        default: ;
    endcase
end

always_ff @ (posedge clk)
begin : next_state_assignment
    state <= next_state;
end

endmodule : VictimCacheControl
