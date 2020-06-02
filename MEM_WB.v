`include "ctrl_encode_def.v"
module MEM_WB ( clk, rst,
	            ins, pc, rd, toReg, RFWr, DMRd, DMWr, DMout, ALUout,
	            //output
	            MEMWB_ins,  MEMWB_pc,   MEMWB_rd,   MEMWB_toReg, 
	            MEMWB_DMRd, MEMWB_DMWr, MEMWB_RFWr, MEMWB_DMout, MEMWB_ALUout );

    input  clk, rst;
    input  RFWr;
    input  [31:0]  ins;
    input  [31:0]  pc;
    input  [31:0]  DMout;
    input  [31:0]  ALUout;
    input  [4:0]   rd;
    input  [1:0]   toReg;
    input  [1:0]   DMWr;
    input  [3:0]   DMRd;      //lw lh lb lhu lbu

    output reg MEMWB_RFWr;
    output reg [4:0]   MEMWB_rd;
    output reg [31:0]  MEMWB_ins;
    output reg [31:0]  MEMWB_pc;  
    output reg [3:0]   MEMWB_DMWr;
    output reg [3:0]   MEMWB_DMRd;      
    output reg [1:0]   MEMWB_toReg;     //PC2Reg Mem2Reg ALU2Reg
    output reg [31:0]  MEMWB_DMout;     
    output reg [31:0]  MEMWB_ALUout; 

initial
begin
    MEMWB_RFWr    <= 1'b0;
    MEMWB_rd      <= 5'b0;
    MEMWB_ins     <= 32'b0;
    MEMWB_pc      <= 32'b0;
    MEMWB_DMWr    <= `DMWr_NOP;
    MEMWB_DMRd    <= `DMRd_NOP;   
    MEMWB_toReg   <= `ALU2Reg;   
    MEMWB_DMout  <= 32'b0;   
    MEMWB_ALUout  <= 32'b0;
end

always @(posedge clk)
begin
    if(rst)
        begin
            MEMWB_RFWr    <= 1'b0;
            MEMWB_rd      <= 5'b0;
            MEMWB_ins     <= 32'b0;
            MEMWB_pc      <= 32'b0;
            MEMWB_DMWr    <= `DMWr_NOP;
            MEMWB_DMRd    <= `DMRd_NOP;   
            MEMWB_toReg   <= `ALU2Reg;   
            MEMWB_DMout  <= 32'b0;   
            MEMWB_ALUout  <= 32'b0;
        end
    else
        begin
            MEMWB_RFWr    <= RFWr;
            MEMWB_rd      <= rd;
            MEMWB_ins     <= ins;
            MEMWB_pc      <= pc;
            MEMWB_DMWr    <= DMWr;
            MEMWB_DMRd    <= DMRd;   
            MEMWB_toReg   <= toReg;   
            MEMWB_DMout   <= DMout;   
            MEMWB_ALUout  <= ALUout;
        end
end
endmodule
