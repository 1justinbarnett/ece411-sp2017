import lc3b_types::*;

module LocalBranchPredictor #(parameter historySize = 5, parameter depth = 1024 )
(
    input iClk,
    
    input iWbBranch,
    input iWbBranchTaken,
    input logic[$clog2(depth)-1:0] iWBPC,
    input logic[$clog2(depth)-1:0] iIDPC,
    input lc3b_nzp iIDNZP,
    input logic[historySize-1:0] iWBBrHistory,
    
    output logic [historySize-1:0] oRShiftOut,
    output logic oBranchPrediction
    
);

logic[1:0] _adderOut;
logic[1:0] _adderIn;
logic _branchPrediction; 
logic [historySize-1:0] _WShiftOut;

PredictorArray #(.depth(2**historySize)) Predictors
(
    .clk(iClk),
    .iRIndex(oRShiftOut),
    .iWIndex(iWBBrHistory),
    .in(_adderOut),
    .we(iWbBranch),
    
    .oROut( _branchPrediction ),
    .oWOut( _adderIn)
);

BrPredAdder PredictionAdder
(
    .in(_adderIn),
    .iOp(iWbBranchTaken),
    
    .out(_adderOut)
);

ShiftRegisterArray #(.depth(depth), .width(historySize)) ShiftRegisterArray_ 
(
    .iClk(iClk),
    .iIn(iWbBranchTaken),
    .iWe(iWbBranch),
    .iRIndex(iIDPC),
    .iWIndex(iWBPC),
    
    .oROut(oRShiftOut),
    .oWOut(_WShiftOut)
);

assign oBranchPrediction = (iIDNZP == 3'b000 ) ? 1'b0 : _branchPrediction; 
endmodule : LocalBranchPredictor
