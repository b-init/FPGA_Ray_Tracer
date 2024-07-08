`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2024 08:16:04 PM
// Design Name: 
// Module Name: prng_fix3
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

// this modules is a prng that generates a psuedorandom vector fixed point number between 0 and 1
// currently hardcoded for Q18.14 fixed point since feedback is not parametrizable yet
`include "defines.svh"

module prng_fix3 (
    input logic gen, rst,
    output fix3_t fix3_rand
    );
    
    prng_fix #(.SEED(14'b00000011011110)) fix_x (
        .gen(gen),
        .rst(rst),
        .fix_rand(fix3_rand.x));
        
    prng_fix #(.SEED(14'b00000011100000)) fix_y (
        .gen(gen),
        .rst(rst),
        .fix_rand(fix3_rand.y));
    
    prng_fix #(.SEED(14'b00000011111110)) fix_z (
        .gen(gen),
        .rst(rst),
        .fix_rand(fix3_rand.z));
    
endmodule
