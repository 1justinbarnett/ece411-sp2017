import lc3b_types::*;

module ExMemPR
(
    input iClk,
    input iLoad, 
    
    input lc3b_mem_control iMemCtrlWord,
    input lc3b_wb_control iWbCtrlWord,
    input lc3b_opcode iOpcode,
    input lc3b_nzp iNzp,
    input lc3b_reg iDr,
    input lc3b_word iPC,
    input lc3b_word iAddr,
    input lc3b_word iAluOut,
//    input lc3b_src_reg iSrcRegs,
    input logic iFlush,

//    output lc3b_src_reg oSrcRegs,
    output lc3b_opcode oOpcode,
    output lc3b_mem_control oMemCtrlWord,
    output lc3b_nzp oNzp,
    output lc3b_reg oDr,
    output lc3b_wb_control oWbCtrlWord,
    output lc3b_word oPC,
    output lc3b_word oAddr,
    output lc3b_word oAluOut
);

lc3b_mem_control _MemControl;
lc3b_wb_control _WbControl;
lc3b_opcode _Opcode;
lc3b_nzp _Nzp;
lc3b_reg _Dr;
lc3b_word _PC;
lc3b_word _Addr;
lc3b_word _AluOut;
//lc3b_src_reg _SrcRegs;

initial
begin
    _Opcode = op_br;
    _WbControl = '{0, 0, 0, 0, 0, 0, 0, 0};
    _MemControl = '{0, 0, 0, 0, 0};
//    _SrcRegs = '{ 0, 0 ,0 ,0 };
    _Nzp = 3'b000;
    _Dr = 3'b000;
    _PC = 16'h0000;
    _Addr = 16'h0000;
    _AluOut= 16'h0000;
end

always_ff @(posedge iClk)
begin
    if (iLoad == 1'b1) begin
        if(iFlush == 1'b0 ) begin
            _Opcode = iOpcode;
            _WbControl = iWbCtrlWord;
            _MemControl = iMemCtrlWord;
//            _SrcRegs = iSrcRegs;
            _Nzp = iNzp;
            _Dr = iDr;
            _PC = iPC;
            _Addr = iAddr;
            _AluOut = iAluOut;

        end 
        else begin
            _Opcode = op_br;
            _WbControl = '{0, 0, 0, 0, 0, 0, 0, 0};
            _MemControl = '{0, 0, 0, 0, 0};
//            _SrcRegs = '{ 0, 0 ,0 ,0 };
            _Nzp = 3'b000;
            _Dr = 3'b000;
            _PC = iPC;
            _Addr = 16'h0000;
            _AluOut= 16'h0000;

        end
    end
end

always_comb 
begin
    oOpcode = _Opcode;
    oWbCtrlWord = _WbControl;
    oNzp = _Nzp;
    oDr = _Dr;
    oMemCtrlWord = _MemControl;
//    oSrcRegs = _SrcRegs;
    oPC = _PC;
    oAddr = _Addr;
    oAluOut = _AluOut;
end

endmodule : ExMemPR
