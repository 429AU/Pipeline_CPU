module PC( clk, rst, npc, pc );

  input              clk;
  input              rst;
  input       [31:0] npc;
  output reg  [31:0] pc;

  always @(posedge clk, posedge rst)
    if (rst) 
      pc <= 32'h0000_0000;
//      PC <= 32'h0000_3000;
    else
      pc <= npc;
      
endmodule

