import lc3b_types::*;

module ControlRom (
    input lc3b_opcode iOpcode,
    input logic iInstr4,
    input logic iInstr5,
    input logic iInstr11,
    
    output logic oStoreMuxSel,
    output logic oDrMuxSel,
    output logic oSr1Used,
    output logic oSr2Used,
    output lc3b_wb_control oWbControl,
    output lc3b_mem_control oMemControl,
    output lc3b_ex_control oExControl
);

always_comb
begin
    oStoreMuxSel = 0;
    oDrMuxSel = 0;
    oSr1Used = 1;
    oSr2Used = 0;
    oWbControl = '{0, 0, 0, 0, 0, 0, 0, 0};
    oMemControl = '{0, 0, 0, 0, 0};
    oExControl = '{0, 0, 0, alu_add, 0, 1};
    
    case(iOpcode)
        op_add: begin
            oWbControl.loadReg = 1;
            oWbControl.loadCC = 1;
            
            if(iInstr5) begin  // if ADDi
                oExControl.sr2MuxSel = 1;
            end else begin
                oSr2Used = 1;
            end
        end
        
        op_and: begin
            oWbControl.loadReg = 1;
            oWbControl.loadCC = 1;
            oExControl.aluop = alu_and;
            
            if(iInstr5) begin  // if ANDi
                oExControl.sr2MuxSel = 1;
            end else begin
                oSr2Used = 1;
            end
        end
        
        op_not: begin
            oWbControl.loadReg = 1;
            oWbControl.loadCC = 1;
            oExControl.aluop = alu_not;
        end
        
        op_ldr: begin
            oWbControl.loadReg = 1;
            oWbControl.loadCC = 1;
            oMemControl.memRead = 1;
            oMemControl.dataMuxSel = 1;
            oExControl.addr1MuxSel = 1;
            oExControl.addr2MuxSel = 1;
        end
        
        op_str: begin
            oStoreMuxSel = 1;
            oMemControl.memWrite = 1;
            oExControl.addr1MuxSel = 1;
            oExControl.addr2MuxSel = 1;
            oExControl.aluop = alu_passb;
        end
        
        op_br: begin
            oWbControl.opBranch = 1;
            oExControl.addr2MuxSel = 2;
            oSr1Used = 0;
        end
        
        op_jsr: begin
            oDrMuxSel = 1;
            oWbControl.loadReg = 1;
            oWbControl.destMuxSel = 2;
            oWbControl.opJmp = 1;
            
            if(iInstr11) begin
                /* JSR */
                oSr1Used = 0;
                oExControl.addr2MuxSel = 3;
            end else begin
                /* JSRR */
                oExControl.addr1MuxSel = 1;
            end
        end
        
        op_jmp: begin
            oWbControl.opJmp = 1;
            oExControl.addr1MuxSel = 1;
        end
        
        op_ldb: begin
            oWbControl.loadReg = 1;
            oWbControl.loadCC = 1;
            oMemControl.memRead = 1;
            oMemControl.dataMuxSel = 1;
            oMemControl.byteEnable = 1;
            oExControl.addr1MuxSel = 1;
            oExControl.addr2MuxSel = 1;
            oExControl.addrShfEn = 0;
        end
        
        op_lea: begin
            oWbControl.loadReg = 1;
            oWbControl.loadCC = 1;
            oWbControl.destMuxSel = 1;
            oExControl.addr2MuxSel = 2;
            oSr1Used = 0;
        end
        
        op_shf: begin
            oWbControl.loadReg = 1;
            oWbControl.loadCC = 1;
            oExControl.sr2MuxSel = 2;
            
            if(~iInstr4) begin
                /* LSFH */
                oExControl.aluop = alu_sll;
            end else begin
                if(~iInstr5)
                    /* RSHFL */
                    oExControl.aluop = alu_srl;
                else
                    /* RSHFA */
                    oExControl.aluop = alu_sra;
            end
        end
        
        op_stb: begin
            oStoreMuxSel = 1;
            oMemControl.memWrite = 1;
            oMemControl.byteEnable = 1;
            oExControl.addr1MuxSel = 1;
            oExControl.addr2MuxSel = 1;
            oExControl.aluop = alu_passb;
            oExControl.sr2MuxSel = 3;
            oExControl.addrShfEn = 0;
        end
        
        op_ldi: begin
            oWbControl.loadReg = 1;
            oWbControl.loadCC = 1;
            oMemControl.memRead = 1;
            oMemControl.dataMuxSel = 1;
            oMemControl.indirect = 1;
            oExControl.addr1MuxSel = 1;
            oExControl.addr2MuxSel = 1;
        end
        
        op_sti: begin
            oStoreMuxSel = 1;
            oMemControl.memWrite = 1;
            oMemControl.indirect = 1;
            oExControl.addr1MuxSel = 1;
            oExControl.addr2MuxSel = 1;
            oExControl.aluop = alu_passb;
        end
        
        op_trap: begin
            oDrMuxSel = 1;
            oWbControl.loadReg = 1;
            oWbControl.destMuxSel = 2;
            oWbControl.opTrap = 1;
            oMemControl.memRead = 1;
            oMemControl.dataMuxSel = 1;
            oExControl.addrMuxSel = 1;
            oSr1Used = 0;
        end
    
        default: ;
    endcase
end

endmodule : ControlRom
