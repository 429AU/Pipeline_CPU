`include "ctrl_encode_def.v"

module NPC( pc, NPCOp, IMM, Rt, RD1, RD2, npc );  // next pc module
   
   input  [31:0] pc;        // pc
   input  [2:0]  NPCOp;     // next pc operation
   input  [25:0] IMM;       // immediate INS[25:0]
   input  [4:0]  Rt;        // bltz, bgez
   input  [31:0] RD1;       // jr, jalr
   input  [31:0] RD2;       

   output reg [31:0] npc;   // next pc
   
   wire [31:0] PCPLUS4;
   
   assign PCPLUS4 = pc + 4; // pc + 4
   
   always @(*) begin
      case (NPCOp)
          `NPC_PLUS4:  npc = PCPLUS4;
          `NPC_BEQ:    npc = (RD1 == RD2) ? (PCPLUS4 + {{14{IMM[15]}}, IMM[15:0], 2'b00}) : (PCPLUS4);  
          `NPC_BNE:    npc = (RD1 == RD2) ? (PCPLUS4) : (PCPLUS4 + {{14{IMM[15]}}, IMM[15:0], 2'b00});
          `NPC_JUMP:   npc = {PCPLUS4[31:28], IMM[25:0], 2'b00};         
          `NPC_REG:    npc = RD1;
          `NPC_BLEZ:   npc = (RD1 ==  0 || RD1[31] == 1) ? (PCPLUS4 + {{14{IMM[15]}}, IMM[15:0], 2'b00}) : (PCPLUS4);
          `NPC_BGTZ:   npc = (RD1 !=  0 && RD1[31] == 0) ? (PCPLUS4 + {{14{IMM[15]}}, IMM[15:0], 2'b00}) : (PCPLUS4);
          `NPC_REGIMM: begin
                case(Rt)
                    5'b00000: npc = (RD1 != 0 && RD1[31] == 1) ? (PCPLUS4 + {{14{IMM[15]}}, IMM[15:0], 2'b00}) : (PCPLUS4);
                    5'b00001: npc = (RD1 == 0 || RD1[31] == 0) ? (PCPLUS4 + {{14{IMM[15]}}, IMM[15:0], 2'b00}) : (PCPLUS4); 
                endcase
          end
          default:     npc = PCPLUS4;
      endcase
   end // end always
   
endmodule
