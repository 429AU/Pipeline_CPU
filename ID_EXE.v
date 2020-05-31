module ID_EXE(  clk, rst, IDEXE_stall, IDEXE_flush,
	            RD1, RD2, rd  //RF
	            Imm32,        // EXT
	            ins, RegDst, NPCOp, DMRd, toReg, ALUOp, DMWr, ALUSrc1, ALUSrc2, RFWr,
	            //output
	            IDEXE_RD1, IDEXE_RD2, IDEXE_Imm32, IDEXE_rd,
	            IDEXE_ins, IDEXE_RegDst, IDEXE_NPCOp, IDEXE_DMRd, IDEXE_toReg, IDEXE_ALUOp, 
	            IDEXE_DMWr, IDEXE_ALUSrc1, IDEXE_ALUSrc2, IDEXE_RFWr);

    input clk, rst, IDEXE_stall, IDEXE_flush;
    input ALUSrc1;
    input ALUSrc2;
    input IDEXE_RFWr;
    input [31:0] RD1;
    input [31:0] RD2;
    input [4:0]  rd;
    input [31:0] Imm32;
    input [31:0] ins;
    input [1:0]  RegDst;    //Rt Rd R31
    input [2:0]  NPCOp;     
    input [3:0]  DMRd;      //lw lh lb lhu lbu
    input [1:0]  toReg;     //PC2Reg Mem2Reg ALU2Reg
    input [3:0]  ALUOp;     
    input [1:0]  DMWr;      //sw sh sb

    output reg IDEXE_ALUSrc1;
    output reg IDEXE_ALUSrc2;
    output reg IDEXE_RFWr;
    output reg [31:0] IDEXE_RD1;
    output reg [31:0] IDEXE_RD2;
    output reg [31:0] IDEXE_Imm32;
    output reg [31:0] IDEXE_ins;
    output reg [1:0]  IDEXE_RegDst;    //Rt Rd R31
    output reg [2:0]  IDEXE_NPCOp;     
    output reg [3:0]  IDEXE_DMRd;      //lw lh lb lhu lbu
    output reg [1:0]  IDEXE_toReg;     //PC2Reg Mem2Reg ALU2Reg
    output reg [3:0]  IDEXE_ALUOp;     
    output reg [1:0]  IDEXE_DMWr;      //sw sh sb


initial
begin
    IDEXE_ALUSrc1 <= `reg;
    IDEXE_ALUSrc2 <= `reg;
    IDEXE_RFWr    <= 1'b0;
    IDEXE_RD1     <= 32'b0;
    IDEXE_RD2     <= 32'b0;
    IDEXE_Imm32   <= 32'b0;
    IDEXE_ins     <= 32'b0;
    IDEXE_RegDst  <= `Rd;
    IDEXE_NPCOp   <= `NPC_PLUS4;
    IDEXE_DMRd    <= `DMRd_NOP;
    IDEXE_toReg   <= `ALU2Reg;
    IDEXE_ALUOp   <= `ALU_NOP;
    IDEXE_DMWr    <= `DMWr_NOP;

end
    