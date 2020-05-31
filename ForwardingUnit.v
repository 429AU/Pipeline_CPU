`include "ctrl_encode_def.v"
module ForwardingUnit( EXEMEM_RFWr, MEMWB_RFWr, MEMWB_DMRd, EXEMEM_DMWr, EXEMEM_rd, MEMWB_rd,
                       IDEXE_rs,    IDEXE_rt,   ALU_A,      ALU_B,       DMdata_ctrl,
                       ALUSrc1,     ALUSrc2);
    input        EXEMEM_RFWr;
    input        MEMWB_RFWr;
    input        MEMWB_DMRd;
    input        EXEMEM_DMWr;
    input        ALUSrc1;
    input        ALUSrc2;
    input [4:0]  EXEMEM_rd;
    input [4:0]  MEMWB_rd;
    input [4:0]  IDEXE_rs;
    input [4:0]  IDEXE_rt;

    output reg [1:0] ALU_A;
    output reg [1:0] ALU_B;
    output reg       DMdata_ctrl;

initial
    begin
        ALU_A       <= `default; 
        ALU_B       <= `default;
        DMdata_ctrl <= 1'b0;
    end

always @(*)
    begin
        ALU_A       <= `default; 
        ALU_B       <= `default;
        DMdata_ctrl <= 1'b0;

        if(EXEMEM_RFWr && (EXEMEM_rd != 0) && (EXEMEM_rd != 31))
            begin
                if( (EXEMEM_rd == IDEXE_rs) && (ALUSrc1 == `reg) ) ALU_A <=  `EXE2EXE;
                if( (EXEMEM_rd == IDEXE_rt) && (ALUSrc2 == `reg) ) ALU_B <=  `EXE2EXE;
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


        if(     MEMWB_DMRd  != `DMRd_NOP 
        	&&  EXEMEM_DMWr != `DMWr_NOP
        	&& (MEMWB_rd == EXEMEM_rd) 
        	&& (MEMWB_rd != 0) 
        	&& (MEMWB_rd != 31)         )
 
            begin
            DMdata_ctrl <= 1'b1; //MEM2MEM
            end
    end
endmodule