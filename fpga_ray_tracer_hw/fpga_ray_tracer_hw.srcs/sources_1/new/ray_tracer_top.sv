`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/01/2024 10:19:49 PM
// Design Name: 
// Module Name: ray_tracer_top
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
`include "fix.sv"

module ray_tracer_top(
    input wire clk, rst);
    
     // to-do: clocking wizard
     ray_t ray_gen;
     wire rvalid;
    
    ray_generator raygen1 (
    .clk(clk),
    .rst(rst),
    .rvalid(rvalid),
    .ray_gen(ray_gen));

endmodule
