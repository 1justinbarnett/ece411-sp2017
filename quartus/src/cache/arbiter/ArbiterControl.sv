module ArbiterControl (
    input iClk,
    
    input logic iMemResp,
    input logic iICacheRead, iICacheWrite,
    input logic iDCacheRead, iDCacheWrite,

    output logic [1:0] oS,
    output logic oPassMemResp
);

enum int unsigned {
    Idle,
    DCache1, DCache2,
    ICache1, ICache2
} _state, _nextState;

logic _ICacheReq, _DCacheReq;

assign _ICacheReq = iICacheRead | iICacheWrite;
assign _DCacheReq = iDCacheRead | iDCacheWrite;

always_comb
begin : state_actions
    oS = 2;
    oPassMemResp = 0;
    
    case(_state)
        DCache1: begin
            oS = 1;
            oPassMemResp = 1;
        end
        
        DCache2: begin
            oS = 1;
        end
        
        ICache1: begin
            oS = 0;
            oPassMemResp = 1;
        end
        
        ICache2: begin
            oS = 0;
        end
        
        default: ;
    endcase
end

always_comb
begin : state_transitions
    _nextState = _state;
    
    case(_state)
        Idle: begin
            if(_DCacheReq)
                _nextState = DCache1;
            else if(_ICacheReq)
                _nextState = ICache1;
        end
        
        DCache1: begin
            if(iMemResp)
                _nextState = DCache2;
        end

        DCache2: begin
            _nextState = Idle;
        end
        
        ICache1: begin
            if(iMemResp)
                _nextState = ICache2;
        end

        ICache2: begin
            _nextState = Idle;
        end
    endcase
end

always_ff @ (posedge iClk)
begin : next_state_assignment
    _state <= _nextState;
end

endmodule : ArbiterControl
