module IF_ID ( clk, rst, IF_pc, IF_ins, ID_pc, ID_ins);

  input              clk;
  input              rst;
  input       [31:0] IF_pc;  
  input       [31:0] IF_ins;

  output reg  [31:0] ID_pc;
  output reg  [31:0] ID_ins;
  
    initial
    begin
        PCPlus4_o <= 32'b0;
        IFIDInstruction <= 32'b0;
    end

    always @(posedge clk) begin
    	if (rst) begin
    		ID_pc  <= 32'b0;
    		ID_ins <= 32'b0;
    	end
    	else begin
    		ID_pc  <= IF_pc;
    		ID_ins <= IF_ins;
    	end
    end
endmodule