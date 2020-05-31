module IF_ID ( clk, rst, IFID_stall, IFID_flush, 
               pc, ins, 
               IFID_pc, IFID_ins );

  input              clk;
  input              rst;
  input              IFID_stall;
  input              IFID_flush;  
  input       [31:0] pc; 
  input       [31:0] ins;

  output reg  [31:0] IFID_pc;
  output reg  [31:0] IFID_ins;
  
    initial
    begin
        IFID_pc  <= 32'b0;
        IFID_ins <= 32'b0;
    end

    always @(posedge clk) begin
    	if (rst) begin
    		IFID_pc  <= 32'b0;
    		IFID_ins <= 32'b0;
    	end
      
      else if(!IFID_stall)
        begin
            if(IFID_flush)
                begin
                    IFID_pc  <= 32'b0;
                    IFID_ins <= 32'b0;
                end
            else
                begin
                    IFID_pc  <= pc;
                    IFID_ins <= ins;
                end
        end
    end
endmodule