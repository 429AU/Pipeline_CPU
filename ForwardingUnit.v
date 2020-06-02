`include "ctrl_encode_def.v"
module ForwardingUnit( EXEMEM_RFWr, MEMWB_RFWr, MEMWB_DMWr, EXEMEM_DMWr, EXEMEM_DMRd,
                       EXEMEM_rd,   MEMWB_rd,   IFID_DMWr,  MEMWB_DMRd,
                       IFID_rs,     IFID_rt,    IDEXE_rd,   IDEXE_RFWr,  IDEXE_DMWr,
                       IDEXE_rs,    IDEXE_rt,   ALU_A,      ALU_B,       DMdata_ctrl,
                       NPC_F1,      NPC_F2,     SW_ctrl,
                       ALUSrc1,     ALUSrc2);
 
    input        EXEMEM_RFWr;
    input        MEMWB_RFWr;
    input        IDEXE_RFWr;
    input [1:0]  IFID_DMWr;
    input [1:0]  IDEXE_DMWr;
    input [1:0]  MEMWB_DMWr;
    input [3:0]  MEMWB_DMRd;
    input [3:0]  EXEMEM_DMRd;
    input [1:0]  EXEMEM_DMWr;
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
    output reg [1:0] SW_ctrl;
    output reg       DMdata_ctrl;

initial
    begin
        ALU_A       <= `default; 
        ALU_B       <= `default;
        NPC_F1      <= 1'b0;
        NPC_F2      <= 1'b0;
        DMdata_ctrl <= 1'b0;
        SW_ctrl     <= 2'b0;
    end

always @(*)
    begin
        ALU_A       <= `default; 
        ALU_B       <= `default;
        NPC_F1      <= 1'b0;
        NPC_F2      <= 1'b0;
        DMdata_ctrl <= 1'b0;
        SW_ctrl     <= 2'b0;

        //NPC forwarding
        if(IDEXE_RFWr && (IDEXE_rd != 0) && (IDEXE_rd != 31))
            begin
                if( (IFID_rs == IDEXE_rd) ) NPC_F1 <= 1'b1;
                if( (IFID_rt == IDEXE_rd) ) NPC_F2 <= 1'b1;
            end

        //toEXE forwarding
        if(EXEMEM_RFWr && (EXEMEM_rd != 0) && (EXEMEM_rd != 31))
            begin
                if( (IDEXE_rs == EXEMEM_rd) ) ALU_A <=  `EXE2EXE;
                if( (IDEXE_rt == EXEMEM_rd) && ALUSrc2 == `reg && (IDEXE_DMWr == `DMWr_NOP) ) ALU_B <=  `EXE2EXE;
            end


        //MEM2EXE forwarding
        if(MEMWB_RFWr && (MEMWB_rd != 0) && (MEMWB_rd != 31))
            begin
                if( !(EXEMEM_RFWr && (EXEMEM_rd != 0) && (EXEMEM_rd != 31) && (EXEMEM_rd == IDEXE_rs)) && MEMWB_DMRd == `DMRd_NOP 
                	&& (MEMWB_rd == IDEXE_rs) )
                    ALU_A <=  `MEM2EXE;
                
                if( !(EXEMEM_RFWr && (EXEMEM_rd != 0) && (EXEMEM_rd != 31) && (EXEMEM_rd == IDEXE_rt)) && MEMWB_DMRd == `DMRd_NOP
                    && (MEMWB_rd == IDEXE_rt) && (IDEXE_DMWr == `DMWr_NOP) )
                    ALU_B <=  `MEM2EXE;

            end


        if( EXEMEM_DMWr != `DMWr_NOP
        	&& (MEMWB_rd == EXEMEM_rd) && (MEMWB_rd != 0) && (MEMWB_rd != 31) && MEMWB_DMWr == `DMWr_NOP)
            begin
            DMdata_ctrl <= 1'b1; //MEM2MEM
            end

        if( IFID_DMWr != `DMWr_NOP && IFID_rt == EXEMEM_rd && (EXEMEM_rd != 0) && (EXEMEM_rd != 31) 
            && EXEMEM_DMWr == `DMWr_NOP )
                if( EXEMEM_DMRd == `DMRd_NOP ) 
                    SW_ctrl <= 2'b01; //other, xxx, SW
                else
                    SW_ctrl <= 2'b10; //LW, xxx, SW 
    end
endmodule