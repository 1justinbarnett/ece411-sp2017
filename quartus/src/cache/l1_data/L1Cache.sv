import lc3b_types::*;
import lc3b_config::*;

module L1DataCache (
	input clk,
	
	input lc3b_word iMemAddress_cpu, iMemWData_cpu,
	input iMemRead_cpu, iMemWrite_cpu, 
	input lc3b_mem_wmask iMemByteEnable_cpu,
	
	input cache_line iMemRData_p,
	input iMemResp_p,
	
	output lc3b_word oMemRData_cpu,
	output logic oMemResp_cpu,
	
	output lc3b_word oMemAddress_p,
	output cache_line oMemWData_p,
	output logic oMemRead_p, oMemWrite_p
);

cache_line _rData, _wData;
logic _resp;
lc3b_word _address;
logic _dirty;
logic _read, _write;

generate 
if (USE_VICTIM_CACHES) begin
DCache DCache_ (
	.clk,
	
	.mem_address(iMemAddress_cpu),
	.mem_wdata(iMemWData_cpu),
	.mem_write(iMemWrite_cpu),
	.mem_read(iMemRead_cpu),
	.mem_byte_enable(iMemByteEnable_cpu),
	
	.pmem_rdata(_rData),
	.pmem_resp(_resp),
	
	.mem_rdata(oMemRData_cpu),
	.mem_resp(oMemResp_cpu),
	
	.oDirty(_dirty),
	
	.pmem_wdata(_wData),
	.pmem_address(_address),
	.pmem_read(_read),
	.pmem_write(_write)
);

VictimCache VictimCache_ (
	.clk,
	
	.iMemRData_p(iMemRData_p),
	.iMemRead_l1(_read),
	.iMemWrite_l1(_write),
	.iMemResp_p(iMemResp_p),
	.iMemWData_l1(_wData),
	.iMemAddress_cpu(_address),
	.iDirty(_dirty),
	.oMemRead_p(oMemRead_p),
	.oMemWrite_p(oMemWrite_p),
	.oMemAddress_p(oMemAddress_p),
	.oMemResp_l1(_resp),
	.oMemRData_l1(_rData),
	.oMemWData_p(oMemWData_p)
);
end else begin
DCache DCache_ (
	.clk,
	
	.mem_address(iMemAddress_cpu),
	.mem_wdata(iMemWData_cpu),
	.mem_write(iMemWrite_cpu),
	.mem_read(iMemRead_cpu),
	.mem_byte_enable(iMemByteEnable_cpu),
	
	.pmem_rdata(iMemRData_p),
	.pmem_resp(iMemResp_p),
	
	.mem_rdata(oMemRData_cpu),
	.mem_resp(oMemResp_cpu),
    
    .oDirty(),
		
	.pmem_wdata(oMemWData_p),
	.pmem_address(oMemAddress_p),
	.pmem_read(oMemRead_p),
	.pmem_write(oMemWrite_p)
);
end
endgenerate

endmodule : L1DataCache
