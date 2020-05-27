`timescale 1ns/1ns

module cpu_test;

reg clk, rst;
wire [31:0] ins;
wire [31:0] pc;


initial begin
    clk = 0;
    rst = 1;
    #1000 rst = 0; 
end
    
    always #100 clk = ~clk;
    cpu cpu1 ( .clk(clk), .rst(rst), .Instruction(ins), .Pc(pc) );

endmodule
