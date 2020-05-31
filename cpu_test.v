`timescale 1ns/1ns

module cpu_test;

reg clk, rst;


initial begin
    clk = 0;
    rst = 1;
    #1000 rst = 0; 
end
    
    always #100 clk = ~clk;
    cpu cpu1 ( .clk(clk), .rst(rst) );

endmodule
