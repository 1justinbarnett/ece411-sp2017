import lc3b_types::*;

module mp3
(
    input iClk,

    /* Memory signals */
    input iMemResp,
    input cache_line iMemRData,
    output logic oMemRead,
    output logic oMemWrite,
    output lc3b_word oMemAddr,
    output cache_line oMemWData
);

/*Cpu to L1*/
lc3b_word _ICacheAddr, _DCacheAddr;
lc3b_word _ICacheRData, _DCacheRData;
lc3b_word _DCacheWData;
logic _DMemRead;
logic _DMemWrite;
logic _ICacheResp, _DCacheResp;
lc3b_mem_wmask _DMemByteEnable;

/*L1 to arbiter*/
lc3b_word _ICachePAddr, _DCachePAddr;
logic _DPMemRead, _IPMemRead;
logic _DPMemWrite;
logic _ICachePResp, _DCachePResp;
cache_line _ICachePRData, _DCachePRData;
cache_line _DPMemWData;

/* arbiter to L2 */
logic _L2Resp;
cache_line _L2RData;
logic _arbiterRead;
logic _arbiterWrite;
lc3b_word _arbiterAddr;
cache_line _arbiterWData;

/* Instantiate MP3 top level blocks here */
Datapath CPU (
    .iClk(iClk),
    
    .iICacheResp(_ICacheResp),
    .iDCacheResp(_DCacheResp),
    .iICacheRData(_ICacheRData),
    .iDCacheRData(_DCacheRData),
    
    .oICacheAddr(_ICacheAddr),
    .oDCacheAddr(_DCacheAddr),
    .oDCacheWData(_DCacheWData),
    .oDMemRead(_DMemRead),
    .oDMemWrite(_DMemWrite),
    .oDMemByteEnable(_DMemByteEnable)
);

L2Cache L2Cache_ (
    .clk(iClk),
    
    /* inputs from cpu */
    .mem_address(_arbiterAddr),
    .mem_wdata(_arbiterWData),
    .mem_read(_arbiterRead),
    .mem_write(_arbiterWrite),
    
    /* inputs from memory */
    .pmem_rdata(iMemRData),
    .pmem_resp(iMemResp),
    
    /* outputs to cpu */
    .mem_rdata(_L2RData),
    .mem_resp(_L2Resp),
    
    /* outputs to memory */
    .pmem_wdata(oMemWData),
    .pmem_address(oMemAddr),
    .pmem_read(oMemRead),
    .pmem_write(oMemWrite)
);

Arbiter Arbiter_ (
    .iClk(iClk),

    /* Memory inputs */
    .iMemResp( _L2Resp ),
    .iMemRData( _L2RData ),

    /* ICache inputs */
    .iICacheRead( _IPMemRead ),
    .iICacheWrite( 1'b0 ),
    .iICacheAddr( _ICachePAddr ),
    
    /* DCache inputs */
    .iDCacheRead( _DPMemRead ),
    .iDCacheWrite( _DPMemWrite ),
    .iDCacheAddr( _DCachePAddr ),
    .iDCacheWData( _DPMemWData),
    
    /* Memory outputs */
    .oMemRead( _arbiterRead ), 
    .oMemWrite( _arbiterWrite ),
    .oMemAddr( _arbiterAddr ),
    .oMemWData( _arbiterWData ),
    
    /* ICache outputs */
    .oICacheResp( _ICachePResp ),
    .oICacheRdata( _ICachePRData ),
    
    /* DCache outputs */
    .oDCacheResp( _DCachePResp ),
    .oDCacheRdata( _DCachePRData )
);

L1InstrCache ICache (
	.clk(iClk),
	
	.iMemAddress_cpu(_ICacheAddr),
	.iMemRead_cpu(1'b1),
	
	.iMemRData_p(_ICachePRData),
	.iMemResp_p(_ICachePResp),
	
	.oMemRData_cpu(_ICacheRData),
	.oMemResp_cpu(_ICacheResp),
	
	.oMemAddress_p(_ICachePAddr),
	.oMemRead_p(_IPMemRead)
);

L1DataCache DCache (
	.clk(iClk),
	
	.iMemAddress_cpu(_DCacheAddr),
    .iMemWData_cpu(_DCacheWData),
	.iMemRead_cpu(_DMemRead),
    .iMemWrite_cpu(_DMemWrite), 
	.iMemByteEnable_cpu(_DMemByteEnable),
	
	.iMemRData_p(_DCachePRData),
	.iMemResp_p(_DCachePResp),
	
	.oMemRData_cpu(_DCacheRData),
	.oMemResp_cpu(_DCacheResp),
	
	.oMemAddress_p(_DCachePAddr),
	.oMemWData_p(_DPMemWData),
	.oMemRead_p(_DPMemRead),
    .oMemWrite_p(_DPMemWrite)
);

endmodule : mp3
