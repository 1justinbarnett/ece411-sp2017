import lc3b_types::*;

module NZPComp
(
	input lc3b_nzp a, b,
    input iOpBranch,
    input iOpJmp,
    input iOpTrap,
    input iIdBranchPredicted,
    input iWbBranchPredicted,
    
    output logic oBrAddrSel,
	output logic [1:0] oPCMuxSel,
    output logic oBrMisprediction
);

logic _brResolved;

always_comb
begin
    _brResolved = (a[0] & b[0]) | (a[1] & b[1]) | (a[2] & b[2]);
    oBrAddrSel = 1'b0;

    oPCMuxSel = 2'b0;
    if(iOpJmp) begin
        oPCMuxSel = 2'd1;
    end else if(iOpTrap) begin
        oPCMuxSel = 2'd2;
    end else if(iOpBranch & (_brResolved != iWbBranchPredicted)) begin
        oPCMuxSel = 2'd1;
        if(_brResolved == 0 )
            oBrAddrSel = 1'b1;
    end else if(iIdBranchPredicted) begin
        oPCMuxSel = 2'd3;
    end
    
    oBrMisprediction = (iWbBranchPredicted != _brResolved) && iOpBranch;
end

endmodule : NZPComp
