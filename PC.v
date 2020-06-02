module PC( clk, rst, PC_stall, jump, npc, pc );

  input              clk;
  input              rst;
  input              jump;
  input              PC_stall;
  input       [31:0] npc;
  output reg  [31:0] pc;

  initial
    begin
      pc <= 32'h0000_0000;
    end

  always @(posedge clk, posedge rst)
  begin
    if (rst) 
      pc <= 32'h0000_0000;
    else
      begin
        if(!PC_stall)
          if(jump)
              pc <= npc;
          else
              pc <= pc + 4;
        else
          pc <= pc;
      end
   end
      
endmodule

