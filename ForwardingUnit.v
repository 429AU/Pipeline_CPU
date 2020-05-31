`include "ctrl_encode_def.v"
module ForwardingUnit( EXMEM_RFWr, MEMWB_RFWr, MEMWB_DMRd, EXMEM_DMWr, EXMEM_rd,
                       IDEX_rs,    IDEX_rt,    ALU_A,      AUL_B,      DMdata_ctrl,
                       ALUSrc1,    ALUSrc2);
    input        EXMEM_RFWr;
    input        MEMWB_RFWr;
    input        MEMWB_DMRd;
    input        EXMEM_DMWr;
    input        ALUSrc1;
    input        ALUSrc2;
    input [4:0]  EXMEM_rd;
    input [4:0]  MEMWB_rd;
    input [4:0]  IDEX_rs;
    input [4:0]  IDEX_rt;

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

        if(EXMEM_RFWr && (EXMEM_rd != 0) && (EXMEM_rd != 31))
            begin
                if( (EXMEM_rd == IDEX_rs) && (ALUSrc1 == `reg) ) ALU_A <=  `EXE2EXE;
                if( (EXMEM_rd == IDEX_rt) && (ALUSrc2 == `reg) ) ALU_B <=  `EXE2EXE;
            end

        if(MEMWB_RFWr && (MEMWB_rd != 0) && (MEMWB_rd != 31))
            begin
                if( !(EXMEM_RFWr && (EXMEM_rd != 0) && (EXMEM_rd != 31) && (EXMEM_rd == IDEX_rs)) //not EXE2EXE
                	&& (MEMWB_rd == IDEX_rs) && (ALUSrc1 == `reg) )
                    ALU_A <=  `MEM2EXE;
                
                if( !(EXMEM_RFWr && (EXMEM_rd != 0) && (EXMEM_rd != 31) && (EXMEM_rd == IDEX_rt)) //not EXE2EXE
                    && (MEMWB_rd == IDEX_rt) && (ALUSrc2 == `reg) )
                    ALU_B <=  `MEM2EXE;
            end


        if(     MEMWB_DMRd != `DMRd_NOP 
        	&&  EXMEM_DMWr != `DMWr_NOP
        	&& (MEMWB_rd == EXMEM_rd) 
        	&& (MEMWB_rd != 0) 
        	&& (MEMWB_rd != 31)         )
 
            begin
            DMdata_ctrl <= 1'b1; //MEM2MEM
            end
    end
endmodule