import lc3b_types::*;

module ID (
    input clk,
    
    input lc3b_opcode iOpcode,
    input logic iInstr4, iInstr5, iInstr11,
    input lc3b_reg iSR1, iSR2, iDR,
    input lc3b_word iWbData,
    input logic iLoadReg,
    input lc3b_reg iWbDR,
    output lc3b_wb_control oWbControl,
    output lc3b_mem_control oMemControl,
    output lc3b_ex_control oExControl,
    output lc3b_word oSR1Data, oSR2Data,
    output logic oSR1Used, oSR2Used,
    output lc3b_reg oDR
);

logic _storeMuxSel;
logic _drMuxSel;
lc3b_reg _storeMuxOut;

ControlRom ControlRom_ (
    .iOpcode(iOpcode),
    .iInstr4(iInstr4),
    .iInstr5(iInstr5),
    .iInstr11(iInstr11),
    .oStoreMuxSel(_storeMuxSel),
    .oDrMuxSel(_drMuxSel),
    .oWbControl(oWbControl),
    .oMemControl(oMemControl),
    .oExControl(oExControl),
    .oSr1Used(oSR1Used),
    .oSr2Used(oSR2Used)
);

Mux2 #(.width(3)) StoreMux (
    .sel(_storeMuxSel),
    .a(iSR2),
    .b(iDR),
    .f(_storeMuxOut)
);

Mux2 #(.width(3)) DrMux (
    .sel(_drMuxSel),
    .a(iDR),
    .b(3'd7),
    .f(oDR)
);

lc3b_word _sr1Data, _sr2Data;
Regfile Regfile_ (
    .clk(clk),
    .load(iLoadReg),
    .in(iWbData),
    .src_a(iSR1),
    .src_b(_storeMuxOut),
    .dest(iWbDR),
    .reg_a(_sr1Data),
    .reg_b(_sr2Data)
);

assign oSR1Data = (iWbDR == iSR1) & iLoadReg ? iWbData : _sr1Data;
assign oSR2Data = (iWbDR == _storeMuxOut) & iLoadReg ? iWbData : _sr2Data;

endmodule : ID
