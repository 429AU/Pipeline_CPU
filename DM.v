`include "ctrl_encode_def.v"
module DM( clk, DMWr, DMRd, DMaddr, DMdata, DMout );
    input                clk;
    input       [1:0]    DMWr;
    input       [3:0]    DMRd;
    input       [31:0]   DMaddr;
    input       [31:0]   DMdata;
    output reg  [31:0]   DMout;

    reg[7:0] RAM [1023:0];
	
  integer i;
	initial
	begin
		for (i = 0; i < 1023; i = i + 1)
        	RAM[i] <= 0;
    DMout <= 32'b0;
	end

always@(*) begin
    if( DMRd != `DMRd_NOP ) begin
	    case(DMRd)
  	        `DMRd_LW:   DMout <= { RAM[DMaddr+3], RAM[DMaddr+2], RAM[DMaddr+1], RAM[DMaddr] };
   	        `DMRd_LH:   DMout <= { {16{RAM[DMaddr+1][7]}}      , RAM[DMaddr+1], RAM[DMaddr] };
   	        `DMRd_LHU:  DMout <= { 16'b0                       , RAM[DMaddr+1], RAM[DMaddr] };
   	        `DMRd_LB:   DMout <= { {24{RAM[DMaddr][7]}}                       , RAM[DMaddr] };
   	        `DMRd_LBU:  DMout <= { 24'b0                                      , RAM[DMaddr] };
   	    endcase
	end
end



always@(posedge clk) begin
    if( DMWr != `DMWr_NOP ) begin
	    case(DMWr)
  	        `DMWr_SW:   { RAM[DMaddr+3], RAM[DMaddr+2], RAM[DMaddr+1], RAM[DMaddr] } <= DMdata[31:0];
   	        `DMWr_SH:   { RAM[DMaddr+1], RAM[DMaddr] } <= DMdata[15:0];
   	        `DMWr_SB:   { RAM[DMaddr] } <= DMdata[7:0];
   	    endcase
	end
end

endmodule
