`include "ctrl_encode_def.v"

module ctrl_unit( opcode, func, 
                  RegDst, NPCOp, DMRd, toReg, ALUOp, DMWr, ALUSrc1, ALUSrc2, RFWr, EXTOp );
    
   input      [5:0] opcode;       
   input      [5:0] func;      

   output reg ALUSrc1;             // reg shamt imm
   output reg ALUSrc2;
   output reg RFWr;
   
   output reg [1:0] RegDst;    //Rt Rd R31
   output reg [2:0] NPCOp;     
   output reg [3:0] DMRd;      //lw lh lb lhu lbu
   output reg [1:0] toReg;     //PC2Reg Mem2Reg ALU2Reg
   output reg [3:0] ALUOp;     
   output reg [1:0] DMWr;      //sw sh sb
   output reg [1:0] EXTOp;     //`signext zero lui

   
   always @(*) begin
      NPCOp = `NPC_PLUS4;
      RegDst = `Rd;
      ALUSrc1 = `reg;
      ALUSrc2 = `reg;
      toReg = `ALU2Reg;
      RFWr = 1'b0;
      DMRd = `DMRd_NOP;
      DMWr = `DMWr_NOP;
      ALUOp = `ALU_NOP;
      EXTOp = `signext; 

      case (opcode)
          `R_type: begin
              NPCOp = `NPC_PLUS4;
              RegDst = `Rd;
              toReg = `ALU2Reg;
              RFWr = 1'b1;
              DMRd = `DMRd_NOP;
              DMWr = `DMWr_NOP;

              // ALU control signal
              case (func)

                  `ADD: begin
                      ALUSrc1 = `reg;
                      ALUSrc2 = `reg;
                      ALUOp   = `ALU_ADD;
                  end

                  `SUB: begin
                      ALUSrc1 = `reg;
                      ALUSrc2 = `reg;
                      ALUOp   = `ALU_SUB;
                  end

                  `AND: begin
                      ALUSrc1 = `reg;
                      ALUSrc2 = `reg;
                      ALUOp   = `ALU_AND;
                  end

                  `OR : begin
                      ALUSrc1 = `reg;
                      ALUSrc2 = `reg;
                      ALUOp   = `ALU_OR;
                  end

                  `SLT: begin
                      ALUSrc1 = `reg;
                      ALUSrc2 = `reg;
                      ALUOp   = `ALU_SLT;
                  end

                  `SLTU : begin
                      ALUSrc1 = `reg;
                      ALUSrc2 = `reg;
                      ALUOp   = `ALU_SLTU;
                  end

                  `ADDU : begin
                      ALUSrc1 = `reg;
                      ALUSrc2 = `reg;
                      ALUOp   = `ALU_ADD;
                  end

                  `SUBU : begin
                      ALUSrc1 = `reg;
                      ALUSrc2 = `reg;
                      ALUOp   = `ALU_SUB;
                  end

                  `XOR : begin
                      ALUSrc1 = `reg;
                      ALUSrc2 = `reg;
                      ALUOp   = `ALU_XOR;
                  end

                  `NOR : begin
                      ALUSrc1 = `reg;
                      ALUSrc2 = `reg;
                      ALUOp   = `ALU_NOR;
                  end

                  `SLL : begin
                      ALUSrc1 = `shamt;
                      ALUSrc2 = `reg;
                      ALUOp   = `ALU_SLL;
                  end

                  `SRA : begin
                      ALUSrc1 = `shamt;
                      ALUSrc2 = `reg;
                      ALUOp   = `ALU_SRA;
                  end

                  `SRAV : begin
                      ALUSrc1 = `reg;
                      ALUSrc2 = `reg;
                      ALUOp   = `ALU_SRA;
                  end

                  `SRL : begin
                      ALUSrc1 = `shamt;
                      ALUSrc2 = `reg;
                      ALUOp   = `ALU_SRL;
                  end

                  `SLLV : begin
                      ALUSrc1 = `reg;
                      ALUSrc2 = `reg;
                      ALUOp   = `ALU_SLL;
                  end

                  `SRLV : begin
                      ALUSrc1 = `reg;
                      ALUSrc2 = `reg;
                      ALUOp   = `ALU_SRL;
                  end

                  `JR : begin
                      ALUOp   = `ALU_NOP;
                      RFWr    = 1'b0; 
                      NPCOp   = `NPC_REG;
                  end

                  `JALR : begin
                      NPCOp   = `NPC_REG;
                      ALUOp   = `ALU_NOP;
                      toReg   = `PC2Reg;
                      RegDst  = `R31;
                  end
              endcase
          end

          `ADDI: begin
              NPCOp   = `NPC_PLUS4;
              RegDst  = `Rt;
              toReg   = `ALU2Reg;
              RFWr    =  1'b1;
              DMRd    = `DMRd_NOP;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `imm;
              ALUOp   = `ALU_ADD;
              EXTOp   = `signext;
          end

          `ORI:  begin
              NPCOp   = `NPC_PLUS4;
              RegDst  = `Rt;
              toReg   = `ALU2Reg;
              RFWr    =  1'b1;
              DMRd    = `DMRd_NOP;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `imm;
              ALUOp   = `ALU_OR;
              EXTOp   = `zero;
          end

          `XORI: begin
              NPCOp   = `NPC_PLUS4;
              RegDst  = `Rt;
              toReg   = `ALU2Reg;
              RFWr    =  1'b1;
              DMRd    = `DMRd_NOP;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `imm;
              ALUOp   = `ALU_XOR;
              EXTOp   = `zero;
          end

          `ADDIU:  begin
              NPCOp   = `NPC_PLUS4;
              RegDst  = `Rt;
              toReg   = `ALU2Reg;
              RFWr    =  1'b1;
              DMRd    = `DMRd_NOP;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `imm;
              ALUOp   = `ALU_ADD;
              EXTOp   = `signext;
          end

          `ANDI: begin
              NPCOp   = `NPC_PLUS4;
              RegDst  = `Rt;
              toReg   = `ALU2Reg;
              RFWr    =  1'b1;
              DMRd    = `DMRd_NOP;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `imm;
              ALUOp   = `ALU_AND;
              EXTOp   = `zero;
          end

          `LUI:  begin
              NPCOp   = `NPC_PLUS4;
              RegDst  = `Rt;
              toReg   = `ALU2Reg;
              RFWr    =  1'b1;
              DMRd    = `DMRd_NOP;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `imm;
              ALUOp   = `ALU_LUI;
              EXTOp   = `lui;
          end

          `SLTI: begin
              NPCOp   = `NPC_PLUS4;
              RegDst  = `Rt;
              toReg   = `ALU2Reg;
              RFWr    =  1'b1;
              DMRd    = `DMRd_NOP;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `imm;
              ALUOp   = `ALU_SLT;
              EXTOp   = `signext;
          end

          `SLTIU: begin
              NPCOp   = `NPC_PLUS4;
              RegDst  = `Rt;
              toReg   = `ALU2Reg;
              RFWr    =  1'b1;
              DMRd    = `DMRd_NOP;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `imm;
              ALUOp   = `ALU_SLTU;
              EXTOp   = `signext;
          end

          `LW: begin
              NPCOp   = `NPC_PLUS4;
              RegDst  = `Rt;
              toReg   = `Mem2Reg;
              RFWr    =  1'b1;
              DMRd    = `DMRd_LW;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `imm;
              ALUOp   = `ALU_ADD;
              EXTOp   = `signext;
          end

          `SW: begin
              NPCOp   = `NPC_PLUS4;
              RegDst  = `Rt;
              toReg   = `Mem2Reg;
              RFWr    =  1'b0;
              DMRd    = `DMRd_NOP;
              DMWr    = `DMWr_SW;
              ALUSrc1 = `reg;
              ALUSrc2 = `imm;
              ALUOp   = `ALU_ADD;
              EXTOp   = `signext;
          end

          `BEQ: begin
              NPCOp   = `NPC_BEQ;
              RegDst  = `Rt;
              toReg   = `ALU2Reg;
              RFWr    =  1'b0;
              DMRd    = `DMRd_NOP;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `reg;
              ALUOp   = `ALU_SUB;
              EXTOp   = `signext;
          end

          `BNE: begin
              NPCOp   = `NPC_BNE;
              RegDst  = `Rt;
              toReg   = `ALU2Reg;
              RFWr    =  1'b0;
              DMRd    = `DMRd_NOP;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `reg;
              ALUOp   = `ALU_SUB;
              EXTOp   = `signext;
          end

          `J: begin
              NPCOp   = `NPC_JUMP;
              RegDst  = `Rt;
              toReg   = `ALU2Reg;
              RFWr    =  1'b0;
              DMRd    = `DMRd_NOP;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `reg;
              ALUOp   = `ALU_NOP;
              EXTOp   = `signext;
          end

          `JAL: begin
              NPCOp   = `NPC_JUMP;
              RegDst  = `R31;
              toReg   = `PC2Reg;
              RFWr    =  1'b1;
              DMRd    = `DMRd_NOP;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `reg;
              ALUOp   = `ALU_NOP;
              EXTOp   = `signext;
          end

          `LB: begin
              NPCOp   = `NPC_PLUS4;
              RegDst  = `Rt;
              toReg   = `Mem2Reg;
              RFWr    =  1'b1;
              DMRd    = `DMRd_LB;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `imm;
              ALUOp   = `ALU_ADD;
              EXTOp   = `signext;
          end

          `LBU: begin
              NPCOp   = `NPC_PLUS4;
              RegDst  = `Rt;
              toReg   = `Mem2Reg;
              RFWr    =  1'b1;
              DMRd    = `DMRd_LBU;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `imm;
              ALUOp   = `ALU_ADD;
              EXTOp   = `signext;
          end

          `LH: begin
              NPCOp   = `NPC_PLUS4;
              RegDst  = `Rt;
              toReg   = `Mem2Reg;
              RFWr    =  1'b1;
              DMRd    = `DMRd_LH;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `imm;
              ALUOp   = `ALU_ADD;
              EXTOp   = `signext;
          end

          `LHU: begin
              NPCOp   = `NPC_PLUS4;
              RegDst  = `Rt;
              toReg   = `Mem2Reg;
              RFWr    =  1'b1;
              DMRd    = `DMRd_LHU;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `imm;
              ALUOp   = `ALU_ADD;
              EXTOp   = `signext;
          end

          `SB: begin
              NPCOp   = `NPC_PLUS4;
              RegDst  = `Rt;
              toReg   = `ALU2Reg;
              RFWr    =  1'b0;
              DMRd    = `DMRd_NOP;
              DMWr    = `DMWr_SB;
              ALUSrc1 = `reg;
              ALUSrc2 = `imm;
              ALUOp   = `ALU_ADD;
              EXTOp   = `signext;
          end

          `SH: begin
              NPCOp   = `NPC_PLUS4;
              RegDst  = `Rt;
              toReg   = `ALU2Reg;
              RFWr    =  1'b0;
              DMRd    = `DMRd_NOP;
              DMWr    = `DMWr_SH;
              ALUSrc1 = `reg;
              ALUSrc2 = `imm;
              ALUOp   = `ALU_ADD;
              EXTOp   = `signext;
          end

          `BLEZ: begin
              NPCOp   = `NPC_BLEZ;
              RegDst  = `Rt;
              toReg   = `ALU2Reg;
              RFWr    =  1'b0;
              DMRd    = `DMRd_NOP;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `reg;
              ALUOp   = `ALU_NOP;
              EXTOp   = `signext;
          end

          `BGTZ: begin
              NPCOp   = `NPC_BGTZ;
              RegDst  = `Rt;
              toReg   = `ALU2Reg;
              RFWr    =  1'b0;
              DMRd    = `DMRd_NOP;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `reg;
              ALUOp   = `ALU_NOP;
              EXTOp   = `signext;
          end

          `REGIMM: begin
              NPCOp   = `NPC_REGIMM;
              RegDst  = `Rt;
              toReg   = `ALU2Reg;
              RFWr    =  1'b0;
              DMRd    = `DMRd_NOP;
              DMWr    = `DMWr_NOP;
              ALUSrc1 = `reg;
              ALUSrc2 = `reg;
              ALUOp   = `ALU_NOP;
              EXTOp   = `signext;
          end
              
      endcase
   end // end always
   
endmodule