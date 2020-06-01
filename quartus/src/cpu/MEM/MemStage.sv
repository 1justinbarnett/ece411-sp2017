import lc3b_types::*;

module MemStage
(
    input iClk,
    input iDataMuxSel,
    input logic iIndirect,
    input logic iLoadIstate,
    input logic iByteEnable,
    input logic iMemRead,
    input logic iMemWrite,
    input lc3b_word iAddr,
    input lc3b_word iWData, /** iALUOut */
    input lc3b_word iMemRData,
    
    input iForwardStoreSel,
    input lc3b_word iMemWBData,
    
    output lc3b_word oMemWData,
    output logic oIstate,
    output logic oMemRead,
    output logic oMemWrite,
    output lc3b_mem_wmask oMemByteEnable,
    output lc3b_word oAddr,
    output lc3b_word oData
);

logic _rwSel;
lc3b_word _regRData;
lc3b_word _modifiedRData; /* RData modified for memByteEnable */

assign _rwSel = iIndirect & ~oIstate;

Counter1b Counter (
    .iClk(iClk),
    .iReset(~iIndirect),
    .iLoad(iLoadIstate),
    .oOut(oIstate)
);

register Temp (
    .clk(iClk),
    .load(iLoadIstate),
    .in(_modifiedRData),
    .out(_regRData)
);

Mux2 #(.width( 16 )) DataMux
(
    .sel( iDataMuxSel ),
    .a( iWData ),
    .b( _modifiedRData ),
    .f( oData )
);

always_comb
begin
    if(iByteEnable) begin
        oMemByteEnable = (iAddr[0]) ? 2'b10 : 2'b01;
    end else begin
        oMemByteEnable = 2'b11;
    end
    
    case(oMemByteEnable)
        2'b00: _modifiedRData = 16'h0000;
        2'b01: _modifiedRData = {8'h00, iMemRData[7:0]};
        2'b10: _modifiedRData = {8'h00, iMemRData[15:8]};
        2'b11: _modifiedRData = iMemRData;
    endcase
end

Mux2 #(.width(1)) MemReadMux (
    .sel(_rwSel),
    .a(iMemRead),
    .b(1'b1),
    .f(oMemRead)
);

Mux2 #(.width(1)) MemWriteMux (
    .sel(_rwSel),
    .a(iMemWrite),
    .b(1'b0),
    .f(oMemWrite)
);

Mux2 AddrMux (
    .sel(oIstate),
    .a(iAddr),
    .b(_regRData),
    .f(oAddr)
);

Mux2 ForwardStoreMux (
    .sel(iForwardStoreSel),
    .a(iWData),
    .b(iMemWBData),
    .f(oMemWData)
);

endmodule : MemStage
