`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2024 05:43:57 PM
// Design Name: 
// Module Name: ray_core
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

module ray_core(
    input wire clk, rst,
    input wire valid,
    input ray_t ray_gen,
    output fix3_t ray_color,
    output reg busy, ready
    );

    fix_t param_a;

    always_ff @(posedge clk) begin

        if (rst) begin
            ray_color <= 32'b0;
            busy <= 1'b0;
            ready <= 1'b1;
        end

        if (valid) begin
            // start processing ray
            busy <= 1'b1;

            // return background if no hit detected
            // since the ray direction's is pre determined now, from -0.9 to 0.9, we can map accordingly
            // without having to worry about variable viewport size

            // map -0.9...0.9 to 0...1
            param_a <= _fix_mul((ray_gen.dirn.y + 32'h0000399a), 32'h0000238e);

            // map from color white to color light blue
            ray_color.x <= _fix_mul((32'h00004000 - param_a), 32'h00004000) + _fix_mul(param_a, 32'h00002000);
            ray_color.y <= _fix_mul((32'h00004000 - param_a), 32'h00004000) + _fix_mul(param_a, 32'h00002ccd);
            ray_color.z <= _fix_mul((32'h00004000 - param_a), 32'h00004000) + _fix_mul(param_a, 32'h00004000);

            ready <= 1'b1;
            busy <= 1'b0;
        end 

    end
endmodule
