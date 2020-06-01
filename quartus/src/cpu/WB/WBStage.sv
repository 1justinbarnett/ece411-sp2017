import lc3b_types::*;

module WBStage
(
    input iClk,
    input lc3b_word iAddr,
    input lc3b_word iOutData,
    input lc3b_word iPC,
    input lc3b_nzp iNZP,
    input logic [1:0] iDestMuxSel,
    input iWbBranchPredicted,
    input iIdBranchPredicted,
    input iOpBranch,
    input iOpJmp,
    input iOpTrap,
    input iLoadCC,
    input iStalling,
     
    output lc3b_word oBrAddr,
    output lc3b_word oRegFileData,
    output logic [1:0] oPCMuxSel,
    output logic oBrMisprediction
);

logic _brAddrSel;
lc3b_nzp _genCCOut;
lc3b_nzp _ccOut;

assign oBrAddr = _brAddrSel ? iPC : iAddr;

int branchCount /* synthesis preserve */;
int missCount /* synthesis preserve */;

initial begin
    branchCount = 0;
    missCount = 0;
end

always_ff @(posedge iClk) begin
    if( ~iStalling ) begin
        if( iOpBranch & (iNZP != 3'b000 )) begin
            branchCount++;
            if( oBrMisprediction )
                missCount++;
        end
    end
end

Mux4 DestMux
(
    .sel( iDestMuxSel ),
    .a( iOutData ),
    .b( iAddr ),
    .c( iPC ),
    .d( 16'h0000 ),
    .f( oRegFileData )
);
NZPComp NZPComp_
(
    .a( _ccOut ),
    .b( iNZP ),
    .iOpBranch( iOpBranch ),
    .iOpJmp( iOpJmp ),
    .iOpTrap( iOpTrap ),
    .iWbBranchPredicted(iWbBranchPredicted),
    .iIdBranchPredicted(iIdBranchPredicted),
    
    .oPCMuxSel( oPCMuxSel ),
    .oBrAddrSel(_brAddrSel),
    .oBrMisprediction(oBrMisprediction)
);

register #( .width(3) ) CC
(
    .clk( iClk ),
    .load( iLoadCC ),
    .in( _genCCOut ),
    .out( _ccOut )
);

Gencc GenCC_
(
    .in( iOutData ),
    .out( _genCCOut )
);

endmodule : WBStage