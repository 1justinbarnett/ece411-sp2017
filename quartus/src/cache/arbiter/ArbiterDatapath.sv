import lc3b_types::*;

module ArbiterDatapath #(parameter n = 128) (
    input iClk,

    /* Control inputs */
    input logic [1:0] iS,
    input logic iPassMemResp,

    /* Memory inputs */
    input logic iMemResp,
    input logic [n-1:0] iMemRData,

    /* ICache inputs */
    input logic iICacheRead, iICacheWrite,
    input lc3b_word iICacheAddr,
    
    /* DCache inputs */
    input logic iDCacheRead, iDCacheWrite,
    input lc3b_word iDCacheAddr,
    input logic [n-1:0] iDCacheWData,
    
    /* Memory outputs */
    output logic oMemRead, oMemWrite,
    output lc3b_word oMemAddr,
    output logic [n-1:0] oMemWData,
    
    /* ICache outputs */
    output logic oICacheResp,
    output logic [n-1:0] oICacheRdata,
    
    /* DCache outputs */
    output logic oDCacheResp,
    output logic [n-1:0] oDCacheRdata
);

/* Mem output buffers */
logic _MemRead, _MemWrite;
lc3b_word _MemAddr;
logic [n-1:0] _MemWData;

assign oICacheRdata = iMemRData;
assign oDCacheRdata = iMemRData;

always_ff @ (posedge iClk)
begin
    oMemRead <= _MemRead;
    oMemWrite <= _MemWrite;
    oMemAddr <= _MemAddr;
    oMemWData <= _MemWData;
end

always_comb
begin
    _MemWData = iDCacheWData;

    case(iS)
        2'b00: begin
            _MemRead = iICacheRead;
            _MemWrite = iICacheWrite;
            _MemAddr = iICacheAddr;
            
            oICacheResp = iPassMemResp ? iMemResp : 1'b0;
            
            oDCacheResp = 1'b0;
        end
        
        2'b01: begin
            _MemRead = iDCacheRead;
            _MemWrite = iDCacheWrite;
            _MemAddr = iDCacheAddr;
            
            oDCacheResp = iPassMemResp ? iMemResp : 1'b0;
            
            oICacheResp = 1'b0;
        end
        
        default: begin
            _MemRead = 1'b0;
            _MemWrite = 1'b0;
            _MemAddr = 16'd0;
            
            oDCacheResp = 1'b0;
            oICacheResp = 1'b0;
        end
    endcase
end

endmodule : ArbiterDatapath
