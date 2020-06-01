import lc3b_types::*;

module VictimCache (
	input clk,
	
	input cache_line iMemRData_p,
	input iMemRead_l1, iMemWrite_l1, 
	
	input iMemResp_p,
	
	input cache_line iMemWData_l1,
	input iDirty,
	input lc3b_word iMemAddress_cpu,
	
	output logic oMemRead_p, oMemWrite_p, oMemResp_l1,
	output cache_line oMemRData_l1,
	output lc3b_word oMemAddress_p,
	output cache_line oMemWData_p
);

/* internal signals */
logic dirty;
logic hit;
logic new_data;
logic we;
logic wdata_sel;
logic wb;
logic enableRandom;

VictimCacheControl VictimCacheControl_ (
	.clk,
	
	.mem_read(iMemRead_l1),
	.mem_write(iMemWrite_l1),
	.mem_resp(oMemResp_l1),
	.pmem_resp(iMemResp_p),
	.pmem_read(oMemRead_p),
	.pmem_write(oMemWrite_p),
	.hit(hit),
	.dirty(dirty),
	.new_data(new_data),
	.we(we),
	.wdata_sel(wdata_sel),
	.wb(wb),
    .enableRandom(enableRandom)
);

VictimCacheDatapath VictimCacheDatapath_ (
	.clk,

	.mem_address(iMemAddress_cpu),
	.pmem_rdata(iMemRData_p),
	.mem_rdata(oMemRData_l1),
	.mem_wdata(iMemWData_l1),
	.pmem_wdata(oMemWData_p),
	.pmem_address(oMemAddress_p),
	.new_data(new_data),
	.iDirty,
	.we(we),
	.wdata_sel(wdata_sel),
	.wb(wb),
	.dirty(dirty),
	.hit(hit),
    .enableRandom(enableRandom)
);

endmodule : VictimCache