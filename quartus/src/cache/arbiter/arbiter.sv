import lc3b_types::*;

module Arbiter #(parameter n = 128) (
    input iClk,

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

logic [1:0] _s;
logic _passMemResp;

ArbiterControl control (
    .*,
    .oS(_s),
    .oPassMemResp(_passMemResp)
);

ArbiterDatapath #(.n(n)) datapath (
    .*,
    .iS(_s),
    .iPassMemResp(_passMemResp)
);

endmodule : Arbiter
