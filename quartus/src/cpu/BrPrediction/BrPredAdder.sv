module BrPredAdder
(
    input logic[1:0] in,
    input logic iOp,
    
    output logic[1:0] out
);

always_comb
begin
    if( ((in == 2'b00) & (iOp == 0))  | ((in == 2'b11) & (iOp == 1))) begin
        out = in;
    end else if( iOp == 1 ) begin
        out = in + 1;
    end else begin
        out = in - 1;
    end
end

endmodule : BrPredAdder