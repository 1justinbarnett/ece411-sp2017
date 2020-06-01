import lc3b_types::*;

module ID_EX (
    input Clk, Load,

    input lc3b_opcode iOpcode,
    input lc3b_wb_control iWbControl,
    input lc3b_nzp iNZP,
    input lc3b_reg iSR1Id,
    input lc3b_reg iSR2Id,
    input lc3b_reg iDR,
    input lc3b_mem_control iMemControl,
    input lc3b_ex_control iExControl,
    input lc3b_word iPC,
    input lc3b_word iSR1Out,
    input lc3b_word iSR2Out,
    input lc3b_offset11 iOffset11,
//    input lc3b_src_reg iSrcRegs,
    input logic iFlush,
    input logic iBrPrediction,
    input logic[4:0] iBrHistory,

    output lc3b_opcode oOpcode,
//    output lc3b_src_reg oSrcRegs,
    output lc3b_wb_control oWbControl,
    output lc3b_nzp oNZP,
    output lc3b_reg oSR1Id,
    output lc3b_reg oSR2Id,
    output lc3b_reg oDR,
    output lc3b_mem_control oMemControl,
    output lc3b_ex_control oExControl,
    output lc3b_word oPC,
    output lc3b_word oSR1Out,
    output lc3b_word oSR2Out,
    output lc3b_imm4 oImm4,
    output lc3b_imm5 oImm5,
    output lc3b_offset6 oOffset6,
    output lc3b_offset9 oOffset9,
    output lc3b_offset11 oOffset11,
    output lc3b_trapvect8 oTrapVector8
);

lc3b_opcode _Opcode;
lc3b_wb_control _WbControl;
lc3b_mem_control _MemControl;
lc3b_ex_control _ExControl;
lc3b_nzp _NZP;
lc3b_reg _DR;
lc3b_word _PC;
lc3b_word _SR1Out;
lc3b_word _SR2Out;
lc3b_reg _SR1Id, _SR2Id;
lc3b_offset11 _Offset11;
//lc3b_src_reg _SrcRegs;

initial
begin
    _Opcode = op_br;
    _WbControl = '{0, 0, 0, 0, 0, 0, 0, 0};
    _MemControl = '{0, 0, 0, 0, 0};
    _ExControl = '{0, 0, 0, alu_add, 0, 1};
//    _SrcRegs = '{ 0, 0 ,0 ,0 };
    _NZP = 3'b000;
    _DR = 3'b000;
    _PC = 16'h0000;
    _SR1Out = 16'h0000;
    _SR2Out = 16'h0000;
    _Offset11 = 11'b00000000000;
end

always_ff @(posedge Clk)
begin
    if (Load == 1'b1) begin
        if(iFlush == 1'b0 ) begin
            _Opcode = iOpcode;
            _WbControl = iWbControl;
            _WbControl.brPrediction = iBrPrediction;
            _WbControl.brHistory = iBrHistory;
            _MemControl = iMemControl;
            _ExControl = iExControl;
//            _SrcRegs = iSrcRegs;
            _SR1Id = iSR1Id;
            _SR2Id = iSR2Id;
            _NZP = iNZP;
            _DR = iDR;
            _PC = iPC;
            _SR1Out = iSR1Out;
            _SR2Out = iSR2Out;
            _Offset11 = iOffset11;
        end 
        else begin
            _Opcode = op_br;
            _WbControl = '{0, 0, 0, 0, 0, 0, 0, 0};
            _MemControl = '{0, 0, 0, 0, 0};
            _ExControl = '{0, 0, 0, alu_add , 0, 0};
//            _SrcRegs = '{ 0, 0 ,0 ,0 };
            _SR1Id = 3'd0;
            _SR2Id = 3'd0;
            _NZP = 3'b000;
            _DR = 3'b000;
            _PC = iPC;
            _SR1Out = 16'h0000;
            _SR2Out = 16'h0000;
            _Offset11 = 11'b00000000000;
        end
    end
end

always_comb 
begin
    oOpcode = _Opcode;
    oWbControl = _WbControl;
    oNZP = _NZP;
    oDR = _DR;
    oMemControl = _MemControl;
    oExControl = _ExControl;
//    oSrcRegs = _SrcRegs;
    oPC = _PC;
    oSR1Out = _SR1Out;
    oSR2Out = _SR2Out;
    oSR1Id = _SR1Id;
    oSR2Id = _SR2Id;
    oImm4 = _Offset11[3:0];
    oImm5 = _Offset11[4:0];
    oOffset6 = _Offset11[5:0];
    oOffset9 = _Offset11[8:0];
    oOffset11 = _Offset11;
    oTrapVector8 = _Offset11[7:0];
end

endmodule : ID_EX 
