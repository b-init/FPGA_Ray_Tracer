`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2024 06:06:44 PM
// Design Name: 
// Module Name: ray_generator
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


//function automatic fix_t _fix_mul(
//    input fix_t a,
//    input fix_t b
//    );
//    logic [`WIDTH_FIX * 2 - 1:0] T, RA, RB;	
//    fix_t TT;
//    logic S1, S2;
//    //reg Fixed RA, RB;
    
//    begin
//        S1 = a[`WIDTH_FIX-1];
//        S2 = b[`WIDTH_FIX-1];

//        RA = (S1) ? ({{`WIDTH_FIX{1'b0}}, ~a + 1}) : {{`WIDTH_FIX{1'b0}}, a};
//        RB = (S2) ? ({{`WIDTH_FIX{1'b0}}, ~b + 1}) : {{`WIDTH_FIX{1'b0}}, b};		
//        T = (RA * RB) >> `WIDTH_FIX_FRAC;           
//        TT = T[`WIDTH_FIX-1:0];
//        _fix_mul = (S1 ^ S2) ? (~TT + 1) : TT;		                    
//    end    
//endfunction

module ray_generator(
    input wire clk, rst,
//    input integer img_width, img_height,
    output logic rvalid,
    // input logic c1_ready,
    output ray_t ray_gen
//    output integer cnt_w, cnt_h, cnt_s
    );
      
    logic done;  
    integer cnt_w, cnt_h, cnt_s;
    fix3_t offset;
    fix3_t sample;
//    fix3_t upperleft;
//    upperleft.x = 32'bffff999a;
//    upperleft.y = 32'b0000399a;
//    upperleft.z = 32'b00004000;
    
    prng_fix3 offset_rng(
        .gen(clk),
        .rst(rst),
        .fix3_rand(offset));
        
    
    always_ff @(posedge clk) begin
        if (rst) begin
            cnt_w <= 0;
            cnt_h <= 0;
            cnt_s <= 0;
            sample <= 0;
            rvalid <= 0;
            done <= 0;
        end
        else if (~done) begin
        
            rvalid <= 1'b0;
            
            if (cnt_h < `IMAGE_HEIGHT) begin
                if (cnt_w < `IMAGE_WIDTH) begin
                    if (cnt_s < `SAMPLES_PER_PX) begin
                        sample.x <= 32'hffff999a + _fix_mul((_fix_from_int(cnt_w) + offset.x), 32'h00000148);
                        sample.y <= 32'h0000399a - _fix_mul((_fix_from_int(cnt_h) + offset.y), 32'h00000148);
                        sample.z <= 32'h00004000;

                        rvalid <= 1'b1;

                        if (cnt_s == `SAMPLES_PER_PX-1) begin
                            cnt_s <= 0;
                            cnt_w <= cnt_w + 1;
                            if (cnt_w == `IMAGE_WIDTH-1) begin
                                cnt_h <= cnt_h + 1;
                                cnt_w <= 0;
                                if (cnt_h == `IMAGE_HEIGHT-1) begin
                                    // rvalid <= 1'b1;
                                    cnt_h <= 0;
                                    done <= 1'b1;
                                end
                            end 
                        end
                        else
                            cnt_s <= cnt_s + 1;
                    end
                end
            end
        end
    end
    
    assign ray_gen.origin = 0;
    assign ray_gen.dirn = sample;
    
endmodule
