`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2024 10:05:12 PM
// Design Name: 
// Module Name: ray_generator_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "defines.svh"
//`include "fix.sv"

module ray_generator_tb();
    
    reg clk, rst;
    reg rvalid;
    ray_t ray_gen;
    integer cw, ch, cs;
    
    ray_generator raygen (clk, rst, rvalid, ray_gen, cw, ch, cs);
    
    initial begin
        rst = 0;
        #10;
        rst = 1;
        #20;
        rst = 0;
    
    end 
    integer fd;
    initial 
        fd = $fopen("output.txt", "w");
        
        always @(posedge clk) begin
            $fwrite(fd, "%b\n %b\n ", ray_gen.dirn.x, ray_gen.dirn.y);
        end
//        $fstrobe(fd, "%b\n", ray_gen.dirn.x);
//        $fstrobe(fd, ray_gen.dirn.y);
    

    initial clk = 0;
    always #1 clk = ~clk;
endmodule
