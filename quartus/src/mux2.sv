module Mux2 #(parameter width = 16) (
    input logic[width - 1:0] a, b,
    input sel,
    output logic[width-1:0] f
);

always_comb
begin
    if (sel == 1'b0) f = a;
    else f = b;
end

endmodule:Mux2
