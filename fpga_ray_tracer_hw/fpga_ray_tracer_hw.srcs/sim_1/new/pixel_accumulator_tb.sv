`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2024 08:26:15 PM
// Design Name: 
// Module Name: pixel_accumulator_tb
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

module pixel_accumulator_tb();
    
    reg clk, rst;
    reg valid, ready, op_valid;
    // ray_t ray_gen;
    integer sample_count;
    fix3_t sample_color, pixel_color;
    rgb24_t rgb_color;
    
    pixel_accumulator pa0 (clk, rst, valid, ready, sample_color, sample_count, pixel_color, rgb_color, op_valid);

    initial begin
        rst = 0;
        sample_color = 0;
        sample_count = 0;
        valid = 0;

        #20;
        rst = 1;
        #20;
        rst = 0;

        #20
        sample_color = 32'h000007ae;
        sample_count = 0;

        #10
        valid = 1;
        
        #20
        sample_color = 32'h000007ae;
        sample_count = 1;
        
        #20
        sample_color = 32'h000007ae;
        sample_count = 2;
        
        #20
        sample_color = 32'h000007ae;
        sample_count = 9;
        
        #20
        sample_color = 32'h000007ae;
        sample_count = 0;
        
        #20
        sample_color = 32'h000007ae;
        sample_count = 1;
        
        #20
        sample_color = 32'h000007ae;
        sample_count = 9;

    
    end 
//    integer fd;
//    initial 
//        fd = $fopen("output.txt", "w");
        
//        always @(posedge clk) begin
//            $fwrite(fd, "%b\n %b\n ", ray_gen.dirn.x, ray_gen.dirn.y);
//        end
//        $fstrobe(fd, "%b\n", ray_gen.dirn.x);
//        $fstrobe(fd, ray_gen.dirn.y);
    

    initial clk = 0;
    always #10 clk = ~clk;
endmodule
