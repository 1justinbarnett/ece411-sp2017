package lc3b_types;

typedef logic [15:0] lc3b_word;
typedef logic  [7:0] lc3b_byte;

typedef logic  [2:0] lc3b_reg;
typedef logic  [2:0] lc3b_nzp;
typedef logic  [1:0] lc3b_mem_wmask;

typedef logic [3:0] lc3b_imm4;
typedef logic [4:0] lc3b_imm5;
typedef logic [5:0] lc3b_offset6;
typedef logic [8:0] lc3b_offset9;
typedef logic [10:0] lc3b_offset11;

typedef logic [7:0] lc3b_trapvect8;

typedef logic [7:0][15:0] cache_line;
typedef logic       [8:0] cache_tag;
typedef logic       [2:0] cache_index;
typedef logic       [3:0] cache_offset;

//typedef logic [127:0] l2_cache_line;
//typedef logic   [6:0] l2_cache_tag;
//typedef logic   [4:0] l2_cache_index;

typedef enum bit [3:0] {
    op_add  = 4'b0001,
    op_and  = 4'b0101,
    op_br   = 4'b0000,
    op_jmp  = 4'b1100,   /* also RET */
    op_jsr  = 4'b0100,   /* also JSRR */
    op_ldb  = 4'b0010,
    op_ldi  = 4'b1010,
    op_ldr  = 4'b0110,
    op_lea  = 4'b1110,
    op_not  = 4'b1001,
    op_rti  = 4'b1000,
    op_shf  = 4'b1101,
    op_stb  = 4'b0011,
    op_sti  = 4'b1011,
    op_str  = 4'b0111,
    op_trap = 4'b1111
} lc3b_opcode;

typedef enum bit [3:0] {
    alu_add,
    alu_and,
    alu_not,
    alu_passa,
    alu_passb,
    alu_sll,
    alu_srl,
    alu_sra
} lc3b_aluop;

typedef struct packed {
    logic addrMuxSel;
    logic addr1MuxSel;
    logic [1:0] addr2MuxSel;
    lc3b_aluop aluop;
    logic [1:0] sr2MuxSel;
    logic addrShfEn;
} lc3b_ex_control;

typedef struct packed {
    logic memRead;
    logic memWrite;
    logic dataMuxSel;
    logic byteEnable;
    logic indirect;
} lc3b_mem_control;

typedef struct packed {
    logic loadReg;
    logic loadCC;
    logic [1:0] destMuxSel;
    logic opBranch;
    logic opTrap;
    logic opJmp;
    logic brPrediction;
    logic [4:0]brHistory;
} lc3b_wb_control;

typedef struct packed {
    lc3b_reg Sr1;
    lc3b_reg Sr2;
    logic Sr1Used;
    logic Sr2Used;
} lc3b_src_reg;

endpackage : lc3b_types
