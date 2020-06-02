`include "ctrl_encode_def.v"
module ForwardingUnit( EXEMEM_RFWr, MEMWB_RFWr, MEMWB_DMRd, EXEMEM_DMWr,
                       EXEMEM_rd,   MEMWB_rd,      
                       IFID_rs,     IFID_rt,    IDEXE_rd,   IDEXE_RFWr,
                       IDEXE_rs,    IDEXE_rt,   ALU_A,      ALU_B,       DMdata_ctrl,
                       NPC_F1,      NPC_F2,
                       ALUSrc1,     ALUSrc2);
    input        EXEMEM_RFWr;
    input        MEMWB_RFWr;
    input        IDEXE_RFWr;
    input        MEMWB_DMRd;
    input        EXEMEM_DMWr;
    input        ALUSrc1;
    input        ALUSrc2;
    input [4:0]  EXEMEM_rd;
    input [4:0]  MEMWB_rd;
    input [4:0]  IFID_rs;
    input [4:0]  IFID_rt;    
    input [4:0]  IDEXE_rs;
    input [4:0]  IDEXE_rt;
    input [4:0]  IDEXE_rd;

    output reg [1:0] ALU_A;
    output reg [1:0] ALU_B;
    output reg       NPC_F1;
    output reg       NPC_F2;
    output reg       DMdata_ctrl;

initial
    begin
        ALU_A       <= `default; 
        ALU_B       <= `default;
        NPC_F1      <= 1'b0;
        NPC_F2      <= 1'b0;
        DMdata_ctrl <= 1'b0;
    end

always @(*)
    begin
        ALU_A       <= `default; 
        ALU_B       <= `default;
        NPC_F1      <= 1'b0;
        NPC_F2      <= 1'b0;
        DMdata_ctrl <= 1'b0;

        if(EXEMEM_RFWr && (EXEMEM_rd != 0) && (EXEMEM_rd != 31))
            begin
                if( (IDEXE_rs == EXEMEM_rd) && (ALUSrc1 == `reg) ) ALU_A <=  `EXE2EXE;
                if( (IDEXE_rt == EXEMEM_rd) && (ALUSrc2 == `reg) ) ALU_B <=  `EXE2EXE;
            end

        if(IDEXE_RFWr && (IDEXE_rd != 0) && (IDEXE_rd != 31))
            begin
                if( (IFID_rs == IDEXE_rd) ) NPC_F1 <= 1'b1;
                if( (IFID_rt == IDEXE_rd) ) NPC_F2 <= 1'b1;
            end


        if(MEMWB_RFWr && (MEMWB_rd != 0) && (MEMWB_rd != 31))
            begin
                if( !(EXEMEM_RFWr && (EXEMEM_rd != 0) && (EXEMEM_rd != 31) && (EXEMEM_rd == IDEXE_rs)) //not EXE2EXE
                	&& (MEMWB_rd == IDEXE_rs) && (ALUSrc1 == `reg) )
                    ALU_A <=  `MEM2EXE;
                
                if( !(EXEMEM_RFWr && (EXEMEM_rd != 0) && (EXEMEM_rd != 31) && (EXEMEM_rd == IDEXE_rt)) //not EXE2EXE
                    && (MEMWB_rd == IDEXE_rt) && (ALUSrc2 == `reg) )
                    ALU_B <=  `MEM2EXE;

            end


        if(  EXEMEM_DMWr != `DMWr_NOP
        	 && (MEMWB_rd == EXEMEM_rd) && (MEMWB_rd != 0) && (MEMWB_rd != 31) )

            begin
            DMdata_ctrl <= 1'b1; //MEM2MEM
            end
    end
endmodule