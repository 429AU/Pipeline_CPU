`include "ctrl_encode_def.v"
module IM( pc, ins );
    input    [9:0]    pc;
    output   [31:0]   ins;

    reg [7:0]   InsMem [1023:0];
    reg [31:0]  fd     [254:0];   //read codes
    reg [31:0]  temp;

    integer  i, addr ;

    initial begin
      addr = 0;
      $readmemh("G:\\Pipeline_CPU\\test_code\\mipstest_extloop.dat", fd);
      for (i = 0; i < 254; i= i + 1) begin
        temp = fd[i];
        InsMem[addr]   = temp[7:0];
        InsMem[addr+1] = temp[15:8]; 
        InsMem[addr+2] = temp[23:16]; 
        InsMem[addr+3] = temp[31:24];  
        addr = addr + 4;
      end
    end

    assign  ins = { InsMem[pc+3], InsMem[pc+2], InsMem[pc+1], InsMem[pc] };

endmodule
