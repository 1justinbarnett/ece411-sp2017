import lc3b_types::*;
import lc3b_config::*;

module Datapath (
    input iClk,
    
    input logic iICacheResp,
    input logic iDCacheResp,
    input lc3b_word iICacheRData,
    input lc3b_word iDCacheRData,
    
    output lc3b_word oICacheAddr,
    output lc3b_word oDCacheAddr,
    output lc3b_word oDCacheWData,
    output logic oDMemRead, oDMemWrite,
    output lc3b_mem_wmask oDMemByteEnable
);

logic _loadPC;
logic _loadIfId;
logic _loadIdEx;
logic _loadExMem;
logic _loadIstate;
logic _loadMemWb;

/* IF Signals */
logic [1:0] _PCMuxSel;
lc3b_word _branchAddr;
lc3b_word _trapAddr;
lc3b_word _ifPC;
logic _flushIfId;

/* ID Signals */
lc3b_reg _ifIdSr1, _ifIdSr2, _idDr;
lc3b_offset11 _idOffset11;
lc3b_opcode _idOpcode;
lc3b_word _idInstruction;
lc3b_word _idPC;
logic _idLoadReg;
logic _idSR1Used;
logic _idSR2Used;
logic _flushIdEx;
logic _btbHit;
lc3b_word _btbAddr;

lc3b_wb_control _idWbControl;
lc3b_mem_control _idMemControl;
lc3b_ex_control _idExControl;
lc3b_word _idSr1Out, _idSr2Out;
lc3b_reg _idDrOut;

logic _brPrediction;
logic [4:0] _brHistory;

/* Forwarding Signals */
lc3b_reg _fIdExSR1Id, _fIdExSR2Id;
lc3b_reg _fMemWbDR, _fExMemDR;
logic _fMemWbLoadReg, _fExMemMemWrite, _fExMemLoadReg;
logic _fForwardStoreSel;
logic[1:0] _fForwardSR1Sel, _fForwardSR2Sel;

/* EX Signals */
lc3b_opcode _exOpcode;
lc3b_wb_control _exWbControl;
lc3b_nzp _exNzp;
lc3b_reg _exDr;
lc3b_mem_control _exMemControl;
lc3b_ex_control _exExControl;
lc3b_word _exPC;
lc3b_word _exSr1Out;
lc3b_word _exSr2Out;
lc3b_imm5 _exImm5;
lc3b_imm4 _exImm4;
lc3b_trapvect8 _exTrapvect8;
lc3b_offset6 _exOffset6;
lc3b_offset9 _exOffset9;
lc3b_offset11 _exOffset11;
logic _flushExMem;

lc3b_word _exAluOut;
lc3b_word _exAddr;

/* MEM Signals */
lc3b_mem_control _memMemControl;
lc3b_wb_control _memWbControl;
lc3b_opcode _memOpcode;
lc3b_nzp _memNzp;
lc3b_reg _memDr;
lc3b_word _memPC;
lc3b_word _memAddr;
lc3b_word _memAluOut;
logic _flushMemWb;

logic _istate;
lc3b_word _memDataOut;

/* WB Signals */
lc3b_wb_control _wbWbControl;
lc3b_opcode _wbOpcode;
lc3b_nzp _wbNzp;
lc3b_reg _wbDr;
lc3b_word _wbPC;
lc3b_word _wbAddr;
lc3b_word _wbDataIn;
logic _branchMispredict;

lc3b_word _wbDataOut;

/* IF */
IF IF_ (
    .clk(iClk),
    
    .iLoadPC(_loadPC),
    .iPCMuxSel(_PCMuxSel),
    .iBranchAddr(_branchAddr),
    .iBrPredictionAddr( _btbAddr ),
    .iTrapAddr(_trapAddr),
    
    .oICacheAddr(oICacheAddr),
    .oPCPlus2(_ifPC)
);

IF_ID IF_ID_ (
    .Clk( iClk ),
    .Load( _loadIfId ),
    
    .iPC(_ifPC),
    .iInstruction(iICacheRData),
    .iFlush(_flushIfId),
    
    .oOpcode(_idOpcode),
    .oInstruction(_idInstruction),
    .oSr1(_ifIdSr1),
    .oSr2(_ifIdSr2),
    .oDr(_idDr),
    .oPC(_idPC),
    .oOffset11(_idOffset11)
);

/* ID */
ID ID_ (
    .clk( iClk ),
    
    .iOpcode(_idOpcode),
    .iInstr4(_idInstruction[4]),
    .iInstr5(_idInstruction[5]),
    .iInstr11(_idInstruction[11]),
    .iSR1(_ifIdSr1),
    .iSR2(_ifIdSr2),
    .iDR(_idDr),
    .iWbData(_wbDataOut),
    .iLoadReg(_idLoadReg),
    .iWbDR(_wbDr),
    
    .oWbControl(_idWbControl),
    .oMemControl(_idMemControl),
    .oExControl(_idExControl),
    .oSR1Data(_idSr1Out),
    .oSR2Data(_idSr2Out),
    .oSR1Used(_idSR1Used),
    .oSR2Used(_idSR2Used), 
    .oDR(_idDrOut)
);

ID_EX ID_EX_ (
    .Clk( iClk ),
    .Load( _loadIdEx ),
    
    .iOpcode(_idOpcode),
    .iWbControl(_idWbControl),
    .iNZP(_idDr),
    .iSR1Id(_ifIdSr1),
    .iSR2Id(_ifIdSr2),
    .iDR(_idDrOut),
    .iMemControl(_idMemControl),
    .iExControl(_idExControl),
    .iPC(_idPC),
    .iSR1Out(_idSr1Out),
    .iSR2Out(_idSr2Out),
    .iOffset11(_idOffset11),
    .iFlush(_flushIdEx),
    .iBrPrediction(_brPrediction),
    .iBrHistory(_brHistory),

    .oOpcode(_exOpcode),
    .oWbControl(_exWbControl),
    .oNZP(_exNzp),
    .oSR1Id(_fIdExSR1Id),
    .oSR2Id(_fIdExSR2Id),
    .oDR(_exDr),
    .oMemControl(_exMemControl),
    .oExControl(_exExControl),
    .oPC(_exPC),
    .oSR1Out(_exSr1Out),
    .oSR2Out(_exSr2Out),
    .oImm4(_exImm4),
    .oImm5(_exImm5),
    .oOffset6(_exOffset6),
    .oOffset9(_exOffset9),
    .oOffset11(_exOffset11),
    .oTrapVector8(_exTrapvect8)
);

/* EX */
stage3 stage3_ (
    .iPC(_exPC),
    .iSR1Out(_exSr1Out),
    .iSR2Out(_exSr2Out),
    .iImm4(_exImm4),
    .iImm5(_exImm5),
    .iTrapVec8(_exTrapvect8),
    .iOffset6(_exOffset6),
    .iOffset9(_exOffset9),
    .iOffset11(_exOffset11),
    .iALUOp(_exExControl.aluop),
    .iSR2MuxSel(_exExControl.sr2MuxSel),
    .iAddr1MuxSel(_exExControl.addr1MuxSel),
    .iAddrMuxSel(_exExControl.addrMuxSel),
    .iAddr2MuxSel(_exExControl.addr2MuxSel),
    .iAddrShfEn(_exExControl.addrShfEn),
    
    .iEXMemAluOut(_memAluOut),
    .iEXMemAddr(_memAddr),
    .iEXMemPC(_memPC),
    .iMemWBData(_wbDataOut),
    .iEXMemDestMuxSel(_memWbControl.destMuxSel),
    .iForwardSR1Sel(_fForwardSR1Sel),
    .iForwardSR2Sel(_fForwardSR2Sel),
    
    .oALUOut(_exAluOut),
    .oAddr(_exAddr)
);

ExMemPR ExMemPR_ (
    .iClk( iClk ),
    .iLoad( _loadExMem ),
    
    .iMemCtrlWord(_exMemControl),
    .iWbCtrlWord(_exWbControl),
    .iOpcode(_exOpcode),
    .iNzp(_exNzp),
    .iDr(_exDr),
    .iPC(_exPC),
    .iAddr(_exAddr),
    .iAluOut(_exAluOut),
    .iFlush(_flushExMem),

    
    .oMemCtrlWord(_memMemControl),
    .oWbCtrlWord(_memWbControl),
    .oOpcode(_memOpcode),
    .oNzp(_memNzp),
    .oDr(_memDr),
    .oPC(_memPC),
    .oAddr(_memAddr),
    .oAluOut(_memAluOut)
);

/* MEM */

MemStage MemStage_ (
    .iClk(iClk),
    .iDataMuxSel(_memMemControl.dataMuxSel),
    .iIndirect(_memMemControl.indirect),
    .iLoadIstate(_loadIstate),
    .iByteEnable(_memMemControl.byteEnable),
    .iMemRead(_memMemControl.memRead),
    .iMemWrite(_memMemControl.memWrite),
    .iAddr(_memAddr),
    .iWData(_memAluOut),
    .iMemRData(iDCacheRData),
    
    .iForwardStoreSel(_fForwardStoreSel),
    .iMemWBData(_wbDataOut),
    
    .oMemWData(oDCacheWData),
    .oIstate(_istate),
    .oMemRead(oDMemRead),
    .oMemWrite(oDMemWrite),
    .oMemByteEnable(oDMemByteEnable),
    .oAddr(oDCacheAddr),
    .oData(_memDataOut)
);

MemWbPR MemWbPR_ (
    .iClk( iClk ),
    .iLoad( _loadMemWb ),
    
    .iWbCtrlWord(_memWbControl),
    .iOpcode(_memOpcode),
    .iNzp(_memNzp),
    .iDr(_memDr),
    .iPC(_memPC),
    .iAddr(_memAddr),
    .iAluOut(_memDataOut),
    .iFlush(_flushMemWb),
    
    .oWbCtrlWord(_wbWbControl),
    .oOpcode(_wbOpcode),
    .oNzp(_wbNzp),
    .oDr(_wbDr),
    .oPC(_wbPC),
    .oAddr(_wbAddr),
    .oAluOut(_wbDataIn)
);

/* WB */
WBStage WBStage_ (
    .iClk(iClk),
    
    .iAddr(_wbAddr),
    .iOutData(_wbDataIn),
    .iPC(_wbPC),
    .iNZP(_wbNzp),
    .iDestMuxSel(_wbWbControl.destMuxSel),
    .iOpBranch(_wbWbControl.opBranch),
    .iOpJmp(_wbWbControl.opJmp),
    .iOpTrap(_wbWbControl.opTrap),
    .iLoadCC(_wbWbControl.loadCC),
    .iWbBranchPredicted(_wbWbControl.brPrediction),
    .iIdBranchPredicted(_brPrediction),
    .iStalling(~_loadMemWb),
    
    .oBrAddr(_branchAddr),
    .oRegFileData(_wbDataOut),
    .oPCMuxSel(_PCMuxSel),
    .oBrMisprediction(_branchMispredict)

);

assign _idLoadReg = _wbWbControl.loadReg;
assign _trapAddr = _wbDataIn;

/* Stalls and hazards */
StallUnit StallUnit_ (
    .iClk(iClk),
    .iICacheResp(iICacheResp),
    .iDCacheResp(iDCacheResp),
    .iMemRead(oDMemRead),
    .iMemWrite(oDMemWrite),
    .iIndirect(_memMemControl.indirect),
    .iIstate(_istate),
    .iIDEXMemRead(_exMemControl.memRead),
    .iIFIDMemRead(_idMemControl.memRead),
    .iIFIDMemWrite(_idMemControl.memWrite),
    .iIDEXDr(_exDr),
    .iIFIDSr1(_ifIdSr1),
    .iIFIDSr1Used(_idSR1Used),
    .iIFIDSr2(_ifIdSr2),
    .iIFIDSr2Used(_idSR2Used),
    .iIdExOpBranch(_exWbControl.opBranch),
    .iIdExOpJmp(_exWbControl.opJmp),
    .iIdExOpTrap(_exWbControl.opTrap),
    .iBrMispredict(_branchMispredict),
    .iBrPredicted( _brPrediction ),
    .iWbOpJmp(_wbWbControl.opJmp),
    .iWbOpTrap(_wbWbControl.opTrap),
    .iPcMuxSel(_PCMuxSel),
    
    .oLoadPC(_loadPC),
    .oLoadIfId(_loadIfId),
    .oLoadIdEx(_loadIdEx),
    .oLoadExMem(_loadExMem),
    .oLoadIstate(_loadIstate),
    .oLoadMemWb(_loadMemWb),
    .oFlushIfId(_flushIfId),
    .oFlushIdEx(_flushIdEx),
    .oFlushExMem(_flushExMem),
    .oFlushMemWb(_flushMemWb)
);

ForwardingUnit ForwardingUnit_ (
    .clk(iClk),
    .iIDEXSr1(_fIdExSR1Id),
    .iIDEXSr2(_fIdExSR2Id),
    .iIDEXDr(_exDr),
    .iEXMemDr(_memDr),
    .iMemWBDr(_wbDr),
    .iEXMemLoadReg(_memWbControl.loadReg),
    .iMemWBLoadReg(_wbWbControl.loadReg),
    .iIDEXMemWrite(_exMemControl.memWrite),
    .iEXMemMemWrite(_memMemControl.memWrite),
    .oForwardStore(_fForwardStoreSel),
    .oForwardSr2(_fForwardSR2Sel),
    .oForwardSr1(_fForwardSR1Sel)
);

/*Branch Prediction*/
generate
if(USE_BRANCH_PREDICTION) begin
    logic _lbpPredicted;
    LocalBranchPredictor #(.historySize(5), .depth(64)) LocalBranchPredictor_ (
        .iClk(iClk),
        
        .iWbBranch(_wbWbControl.opBranch & (_wbNzp != 3'b000)),
        .iIDNZP(_idDr),
        .iWbBranchTaken( _PCMuxSel == 2'b01 ),
        .iWBPC( _wbPC[6:1]),
        .iIDPC( _idPC[6:1]),
        .iWBBrHistory( _wbWbControl.brHistory ),
        
        .oRShiftOut( _brHistory ),
        .oBranchPrediction(_lbpPredicted)
    );

    BTB #(.linesize(16), .sets(4)) BTB_ (
        .iClk(iClk),
        
        .iWbBranch(_wbWbControl.opBranch & (_wbNzp != 3'b000)),
        .iWPc(_wbPC),
        .iRPc(_idPC),
        .iWbBranchAddr(_wbAddr),
        
        .oRHit(_btbHit),
        .oBrAddr(_btbAddr)
    );

    assign _brPrediction = _lbpPredicted & _btbHit & _idWbControl.opBranch;
end else begin
    assign _brHistory = 5'd0;
    assign _btbHit = 1'b0;
    assign _btbAddr = 16'd0;
    assign _brPrediction = 1'b0;
end
endgenerate

endmodule : Datapath
