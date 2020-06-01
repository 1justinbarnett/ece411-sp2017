import lc3b_types::*;

module IF (
    input clk,

    input logic iLoadPC,
    input logic [1:0] iPCMuxSel,
    input lc3b_word iBranchAddr,
    input lc3b_word iBrPredictionAddr,
    input lc3b_word iTrapAddr,
    output lc3b_word oICacheAddr,
    output lc3b_word oPCPlus2
);

lc3b_word _PCMuxOut;

Plus2 Plus2_ (
    .in(oICacheAddr),
    .out(oPCPlus2)
);

Mux4 PCMux (
    .sel(iPCMuxSel),
    .a(oPCPlus2),
    .b(iBranchAddr),
    .c(iTrapAddr),
    .d(iBrPredictionAddr),
    .f(_PCMuxOut)
);

register PC (
    .clk(clk),
    .load(iLoadPC),
    .in(_PCMuxOut),
    .out(oICacheAddr)
);

endmodule : IF
