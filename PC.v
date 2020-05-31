module PC( clk, rst, stall, npc, pc );

  input              clk;
  input              rst;
  input              stall;
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
        if(!stall)
          pc <= npc;
        else
          pc <= pc;
      end
   end
      
endmodule

