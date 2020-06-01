import lc3b_types::*;

module StallUnit (
    input iClk,
    input iICacheResp,
    input iDCacheResp,
    input iMemRead,
    input iMemWrite,
    input iIndirect,
    input iIstate,
    input iIDEXMemRead,
    input iIFIDMemWrite,
    input iIFIDMemRead,
    input lc3b_reg iIDEXDr,
    input lc3b_reg iIFIDSr1,
    input iIFIDSr1Used,
    input lc3b_reg iIFIDSr2,
    input iIFIDSr2Used,
    input iIdExOpBranch,
    input iIdExOpJmp,
    input iIdExOpTrap,
    input iBrPredicted,
    input iBrMispredict,
    input iWbOpJmp,
    input iWbOpTrap,
    input logic[1:0] iPcMuxSel,
    
    output logic oLoadPC,
    output logic oLoadIfId,
    output logic oLoadIdEx,
    output logic oLoadExMem,
    output logic oLoadIstate,
    output logic oLoadMemWb,
    output logic oFlushIfId,
    output logic oFlushIdEx,
    output logic oFlushExMem,
    output logic oFlushMemWb
);

logic _memAccess;
logic _totalStall;
logic _idexIfidDepend;
logic _pcChange;
logic _pcChangeHazard;

int bubbleCount /* synthesis preserve */;
int instrCount /* synthesis preserve */;

initial begin
    bubbleCount = 0;
    instrCount = 0;
end

always_ff @ (posedge iClk)
begin
    if(~_totalStall) begin
        instrCount++;
        if((iIDEXMemRead & _idexIfidDepend) | _pcChangeHazard)
            bubbleCount++;
    end
end

always_comb
begin
    _memAccess = iMemRead | iMemWrite;
    _totalStall = ~iICacheResp | (_memAccess & ~iDCacheResp) | (_memAccess & iIndirect & ~iIstate);
    _idexIfidDepend =((iIDEXDr == iIFIDSr1) & iIFIDSr1Used ) | ((iIDEXDr == iIFIDSr2) & iIFIDSr2Used);
    
    _pcChange = iWbOpJmp | iWbOpTrap | iBrMispredict;
    _pcChangeHazard = (iIFIDMemRead | iIFIDMemWrite) & (iIdExOpBranch | iIdExOpJmp | iIdExOpTrap);
    
    oLoadPC = ~_totalStall & (((~iIDEXMemRead | ~_idexIfidDepend ) & ~_pcChangeHazard) | _pcChange);
    oLoadIfId = (~_totalStall & (((~iIDEXMemRead | ~_idexIfidDepend ) & ~_pcChangeHazard) | _pcChange)) | iBrPredicted;
    oLoadIdEx = ~_totalStall;
    oLoadExMem = ~_totalStall;
    oLoadIstate = ~_totalStall | (iIndirect & ~iIstate & iDCacheResp);
    oLoadMemWb = ~_totalStall;
    
    oFlushIfId = _pcChange | iBrPredicted;
    oFlushIdEx = (~_totalStall & iIDEXMemRead & _idexIfidDepend) | _pcChangeHazard | _pcChange;
    oFlushExMem = _pcChange;
    oFlushMemWb = _pcChange;
end

endmodule : StallUnit
