import lc3b_types::*;
import lc3b_config::*;

module L1InstrCache (
	input clk,
	
	input lc3b_word iMemAddress_cpu,
	input iMemRead_cpu,
	
	input cache_line iMemRData_p,
	input iMemResp_p,
	
	output lc3b_word oMemRData_cpu,
	output logic oMemResp_cpu,
	
	output lc3b_word oMemAddress_p,
	output logic oMemRead_p
);

cache_line _rData, _wData;
logic _resp;
lc3b_word _address;
logic _read, _write;

//ICache ICache_ (
//	.clk,
//	
//	.mem_address(iMemAddress_cpu),
//	.mem_read(iMemRead_cpu),
//	
//	.pmem_rdata(_rData),
//	.pmem_resp(_resp),
//	
//	.mem_rdata(oMemRData_cpu),
//	.mem_resp(oMemResp_cpu),
//	
//	.pmem_wdata(_wData),
//	.pmem_address(_address),
//	.pmem_read(_read),
//	.pmem_write(_write)
//);

generate
if (USE_VICTIM_CACHES) begin
DCache DCache_ (
	.clk,
	
	.mem_address(iMemAddress_cpu),
	.mem_read(iMemRead_cpu),
	.mem_write(1'b0),
	.mem_wdata(0),
	
	.pmem_rdata(_rData),
	.pmem_resp(_resp),
	
	.oDirty(),
	.mem_byte_enable(2'b0),
	
	.mem_rdata(oMemRData_cpu),
	.mem_resp(oMemResp_cpu),
	
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
	.iDirty(1'b0),
	.oMemRead_p(oMemRead_p),
	.oMemWrite_p(),
	.oMemAddress_p(oMemAddress_p),
	.oMemResp_l1(_resp),
	.oMemRData_l1(_rData),
	.oMemWData_p()
);
end else begin
ICache ICache_ (
	.clk,
	
	.mem_address(iMemAddress_cpu),
	.mem_read(iMemRead_cpu),
	
	.pmem_rdata(iMemRData_p),
	.pmem_resp(iMemResp_p),
	
	.mem_rdata(oMemRData_cpu),
	.mem_resp(oMemResp_cpu),
	
	.pmem_address(oMemAddress_p),
	.pmem_read(oMemRead_p)
);
end
endgenerate

endmodule : L1InstrCache
