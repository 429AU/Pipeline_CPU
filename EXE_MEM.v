`include "ctrl_encode_def.v"
module EXE_MEM( clk, rst,
	            ins, pc, rd, toReg, DMRd, DMWr, RFWr, DMdata, ALUout,
	            //output
	            EXEMEM_ins, EXEMEM_pc, EXEMEM_rd, EXEMEM_toReg, 
	            EXEMEM_DMRd, EXEMEM_DMWr, EXEMEM_RFWr, EXEMEM_DMdata, EXEMEM_ALUout );

    input  clk, rst;
    input  RFWr;
    input  [31:0]  ins;
    input  [31:0]  pc;
    input  [31:0]  DMdata;
    input  [31:0]  ALUout;
    input  [4:0]   rd;
    input  [1:0]   toReg;
    input  [3:0]   DMRd;      //lw lh lb lhu lbu
    input  [1:0]   DMWr;      //sw sh sb

    output reg EXEMEM_RFWr;
    output reg [4:0]   EXEMEM_rd;
    output reg [31:0]  EXEMEM_ins;
    output reg [31:0]  EXEMEM_pc;
    output reg [1:0]   EXEMEM_DMWr;  
    output reg [3:0]   EXEMEM_DMRd;      
    output reg [1:0]   EXEMEM_toReg;     //PC2Reg Mem2Reg ALU2Reg
    output reg [31:0]  EXEMEM_DMdata;     
    output reg [31:0]  EXEMEM_ALUout; 

initial
begin
    EXEMEM_RFWr    <= 1'b0;
    EXEMEM_rd      <= 5'b0;
    EXEMEM_ins     <= 32'b0;
    EXEMEM_pc      <= 32'b0;
    EXEMEM_DMWr    <= `DMWr_NOP;
    EXEMEM_DMRd    <= `DMRd_NOP;   
    EXEMEM_toReg   <= `ALU2Reg;   
    EXEMEM_DMdata  <= 32'b0;   
    EXEMEM_ALUout  <= 32'b0;
end

always @(posedge clk)
begin
    if(rst)
        begin
            EXEMEM_RFWr    <= 1'b0;
            EXEMEM_rd      <= 5'b0;
            EXEMEM_ins     <= 32'b0;
            EXEMEM_pc      <= 32'b0;
            EXEMEM_DMWr    <= `DMWr_NOP;
            EXEMEM_DMRd    <= `DMRd_NOP;   
            EXEMEM_toReg   <= `ALU2Reg;   
            EXEMEM_DMdata  <= 32'b0;   
            EXEMEM_ALUout  <= 32'b0;
        end
    else
        begin
            EXEMEM_RFWr    <= RFWr;
            EXEMEM_rd      <= rd;
            EXEMEM_ins     <= ins;
            EXEMEM_pc      <= pc;
            EXEMEM_DMWr    <= DMWr;
            EXEMEM_DMRd    <= DMRd;   
            EXEMEM_toReg   <= toReg;   
            EXEMEM_DMdata  <= DMdata;   
            EXEMEM_ALUout  <= ALUout;
        end
end
endmodule