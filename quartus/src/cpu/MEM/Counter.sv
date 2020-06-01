module Counter1b (
    input iClk,
    input iReset,
    input iLoad,
    
    output logic oOut
);

always_ff @ (posedge iClk)
begin
    if(iLoad) begin
        if(iReset)
            oOut <= 0;
        else
            oOut++;
    end
end

endmodule : Counter1b
