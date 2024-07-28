`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/28/2024 03:53:40 PM
// Design Name: 
// Module Name: fix3_to_RGB
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

module fix3_to_RGB(
    input fix3_t pixel_color,
    output rgb24_t rgb_color
    );

    fix_to_RGB fix_to_rgb_r (pixel_color.x, rgb_color.r);
    fix_to_RGB fix_to_rgb_g (pixel_color.y, rgb_color.g);
    fix_to_RGB fix_to_rgb_b (pixel_color.z, rgb_color.b);

endmodule

module fix_to_RGB(
    input fix_t fix_color,
    output color8_t int_color
    );
    
    fix_t scaled_color;

    always_comb begin
        if (_fix_lesser_equal(fix_color, 32'b0)) // <= 0
            scaled_color = 32'b0;
        else if (_fix_greater_equal(fix_color, 32'h00003fbe)) // >= 0.996
            scaled_color = 32'b00000000001111111100000000000000;
        else 
            scaled_color = _fix_mul(fix_color, 32'h00400000);
    end
    
    assign int_color = scaled_color[21:14];
    
endmodule
