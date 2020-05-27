`include "ctrl_encode_def.v"
module EXT( Imm16, EXTOp, Imm32 );

   input       [1:0]   EXTOp;    
   input       [15:0]  Imm16;
   output reg  [31:0]  Imm32;
   
   always @(*) begin
      case (EXTOp)
          `signext:    Imm32 = {{16{Imm16[15]}}, Imm16};
          `zero:       Imm32 = {16'd0, Imm16};   
          `lui:        Imm32 = {Imm16, 16'd0};      
          default:     Imm32 = {{16{Imm16[15]}}, Imm16};
      endcase
   end // end always



endmodule
