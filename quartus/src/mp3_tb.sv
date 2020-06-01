import lc3b_types::*;

module mp3_tb;

timeunit 1ns;
timeprecision 1ns;

logic _clk;
logic _MemResp;
cache_line _MemRData;
logic _MemRead;
logic _MemWrite;
lc3b_word _MemAddr;
cache_line _MemWData;

/* Clock generator */
initial _clk = 0;
always #5 _clk = ~_clk;

mp3 dut
(
    .iClk(_clk),
    
    .iMemResp( _MemResp ),
    .iMemRData( _MemRData ),
    .oMemRead( _MemRead ),
    .oMemWrite( _MemWrite ),
    .oMemAddr( _MemAddr ),
    .oMemWData( _MemWData )
);

physical_memory mem
(
    .clk(_clk),
    .read(_MemRead),
    .write(_MemWrite),
    .address(_MemAddr),
    .wdata(_MemWData),
    .resp(_MemResp),
    .rdata(_MemRData)
);

endmodule : mp3_tb
