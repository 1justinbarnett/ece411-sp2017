import lc3b_types::*;

module stage3 (
    input lc3b_word iPC,
    input lc3b_word iSR1Out,
    input lc3b_word iSR2Out,
    input lc3b_imm4 iImm4,
    input lc3b_imm5 iImm5,
    input lc3b_trapvect8 iTrapVec8,
    input lc3b_offset6 iOffset6,
    input lc3b_offset9 iOffset9,
    input lc3b_offset11 iOffset11,
    input lc3b_aluop iALUOp,
    input logic [1:0] iSR2MuxSel,
    input logic iAddr1MuxSel,
    input logic iAddrMuxSel,
    input logic [1:0] iAddr2MuxSel,
    input logic iAddrShfEn,
    
    /** Forwarding In
     */
     
    input lc3b_word iEXMemAluOut,
    input lc3b_word iEXMemAddr,
    input lc3b_word iEXMemPC,
    input lc3b_word iMemWBData,
    input logic[1:0] iEXMemDestMuxSel,
    input logic[1:0] iForwardSR1Sel,
    input logic[1:0] iForwardSR2Sel,

    output lc3b_word oALUOut,
    output lc3b_word oAddr
);

lc3b_word _addr2MuxOut;
lc3b_word _sr2MuxOut;
lc3b_word _adder2Out;
lc3b_word _addr1MuxOut;

lc3b_word _memForwardData;
lc3b_word _forwardSR1MuxOut;
lc3b_word _forwardSR2MuxOut;

/* ALU */
Alu Alu_ (
    .a(_forwardSR1MuxOut),
    .b(_sr2MuxOut),
    .aluop(iALUOp),
    .f(oALUOut)
);

Mux4 SR2Mux (
    .a(_forwardSR2MuxOut),
    .b(16'(signed'(iImm5))),
    .c({12'h000, iImm4}),
    .d({_forwardSR2MuxOut[7:0], _forwardSR2MuxOut[7:0]}),
    .sel(iSR2MuxSel),
    .f(_sr2MuxOut)
);

/* Address Generation */
Mux2 Addr1Mux (
    .sel(iAddr1MuxSel),
    .a(iPC),
    .b(_forwardSR1MuxOut),
    .f(_addr1MuxOut)
);

Mux4 Addr2Mux (
    .a(16'h0000),
    .b(16'(signed'(iOffset6))),
    .c(16'(signed'(iOffset9))),
    .d(16'(signed'(iOffset11))),
    .sel(iAddr2MuxSel),
    .f(_addr2MuxOut)
);

Adder2 PCAdder (
    .a(_addr1MuxOut),
    .b((iAddrShfEn) ? {_addr2MuxOut[14:0], 1'b0} : _addr2MuxOut),
    .f(_adder2Out)
);

Mux2 AddrMux (
    .sel(iAddrMuxSel),
    .a(_adder2Out),
    .b({7'b0000000, iTrapVec8, 1'b0}),
    .f(oAddr)
);

Mux4 #(.width(16)) EXMemForwardDataMux (
    .sel(iEXMemDestMuxSel),
    .a(iEXMemAluOut),
    .b(iEXMemAddr),
    .c(iEXMemPC),
    .d(16'd0),
    .f(_memForwardData)
);

Mux4 #(.width(16)) ForwardSR1 (
    .a(iSR1Out),
    .b(_memForwardData),
    .c(iMemWBData),
    .d(16'd0),
    .sel(iForwardSR1Sel),
    .f(_forwardSR1MuxOut)
);

Mux4 #(.width(16)) ForwardSR2 (
    .a(iSR2Out),
    .b(_memForwardData),
    .c(iMemWBData),
    .d(16'd0),
    .sel(iForwardSR2Sel),
    .f(_forwardSR2MuxOut)
);

endmodule : stage3