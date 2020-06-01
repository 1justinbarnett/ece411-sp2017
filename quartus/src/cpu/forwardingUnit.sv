import lc3b_types::*;

module ForwardingUnit (
    input clk,
    input lc3b_reg iIDEXSr1,
    input lc3b_reg iIDEXSr2,
    input lc3b_reg iIDEXDr,
    input lc3b_reg iEXMemDr,
    input lc3b_reg iMemWBDr,

    input logic iEXMemLoadReg,
    input logic iMemWBLoadReg,

    input logic iIDEXMemWrite,
    input logic iEXMemMemWrite,

    output logic oForwardStore,
    output logic [1:0] oForwardSr2,
    output logic [1:0] oForwardSr1
);

always_comb 
begin
    oForwardSr1 = 2'b0;
    if ((iIDEXSr1 == iEXMemDr) & iEXMemLoadReg) begin
        oForwardSr1 = 2'b01;
    end else if ((iIDEXSr1 == iMemWBDr) & iMemWBLoadReg) begin
        oForwardSr1 = 2'b10;
    end

    oForwardSr2 = 2'b0;
    if ((iIDEXDr == iMemWBDr) & iIDEXMemWrite & iMemWBLoadReg) begin
        oForwardSr2 = 2'b10;
    end else if ((iIDEXSr2 == iEXMemDr) & ~iIDEXMemWrite & iEXMemLoadReg) begin
        oForwardSr2 = 2'b01;
    end else if ((iIDEXSr2 == iMemWBDr) & iMemWBLoadReg) begin
        oForwardSr2 = 2'b10;
    end

    oForwardStore = (iEXMemDr == iMemWBDr) & iEXMemMemWrite & iMemWBLoadReg;
end

endmodule : ForwardingUnit
