import lc3b_types::*;

module IF_ID (
    input Clk, Load,
    input lc3b_word iPC,
    input lc3b_word iInstruction,
    input logic iFlush,

    output lc3b_opcode oOpcode,
    output lc3b_word oInstruction,
    output lc3b_reg oSr1,
    output lc3b_reg oSr2,
    output lc3b_reg oDr,
    output lc3b_word oPC,
    output lc3b_offset11 oOffset11
);

lc3b_word _Instruction;
lc3b_word _PC;

initial
begin
    _Instruction = 16'h0000;
    _PC = 16'h0000;
end

always_ff @(posedge Clk)
begin
    if (Load == 1'b1) begin
        if (iFlush == 1'b0) begin
            _Instruction = iInstruction;
            _PC = iPC;
        end
        else begin
            _Instruction = 16'h0000;
            _PC = iPC;
        end
    end
end

always_comb
begin
    oOffset11 = _Instruction[10:0];
    oDr = _Instruction[11:9];
    oSr1 = _Instruction[8:6];
    oSr2 = _Instruction[2:0];
    oOpcode = lc3b_opcode'(_Instruction[15:12]);
    oPC = _PC;
    oInstruction = _Instruction;
end

endmodule : IF_ID
