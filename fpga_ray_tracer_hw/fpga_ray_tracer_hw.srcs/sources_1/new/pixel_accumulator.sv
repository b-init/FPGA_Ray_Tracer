`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2024 01:11:04 AM
// Design Name: 
// Module Name: pixel_accumulator
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

module pixel_accumulator(
    input wire clk, rst,
    // input integer w, h, s,
    input reg valid,
    output reg ready,
    input fix3_t sample_color,
    input integer sample_count,
    output fix3_t pixel_color,
    output rgb24_t rgb_color,
    output reg op_valid
    );

    fix3_t buffer;
    integer buffer_count;
    fix3_t sum;

    fix3_to_RGB fix3_to_rgb (pixel_color, rgb_color);

    always_ff @(posedge clk) begin
        if (rst) begin
            buffer <= 32'b0;
            buffer_count <= 32'b0;
            sum <= 32'b0;
            // pixel_color <= 32'b0;
            op_valid <= 1'b0;
            ready <= 1'b1;
//            rgb_color <= 0;
        end

        if (ready & valid) begin
            buffer <= sample_color;
            buffer_count <= sample_count;
            ready <= 1'b0;
        end

        if (~ready) begin
            sum.x <= sum.x + _fix_mul(32'h00000666, buffer.x); // * 1/SAMPLES
            sum.y <= sum.y + _fix_mul(32'h00000666, buffer.y); // * 1/SAMPLES
            sum.z <= sum.z + _fix_mul(32'h00000666, buffer.z); // * 1/SAMPLES
            ready <= 1'b1;
        end

        if (sample_count == `SAMPLES_PER_PX-1) begin
            pixel_color <= sum;
            op_valid <= 1'b1;
        end
        else begin
            op_valid <= 1'b0;
        end
    end

endmodule
