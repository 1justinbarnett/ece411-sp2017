module Mux4 #(parameter width = 16) (
    input logic[width - 1:0] a, b, c, d,
    input logic[1:0] sel,
    output logic[width - 1:0] f
);

always_comb
begin
    case(sel)
        2'b00: begin
            f = a;
        end
        2'b01: begin
            f = b;
        end
        2'b10: begin
            f = c;
        end
        2'b11: begin
            f = d;
        end
    endcase
end

endmodule : Mux4
