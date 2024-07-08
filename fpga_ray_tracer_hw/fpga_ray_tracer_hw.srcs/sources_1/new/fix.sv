`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2024 09:08:45 PM
// Design Name: 
// Module Name: fix
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
`ifndef FIX_SV
`define FIX_SV

`include "defines.svh"

function automatic fix_t _fix_from_int(
    input [`WIDTH_FIX-1:0] v
    );
    
    begin
        if (v[`WIDTH_FIX-1]) begin
            _fix_from_int = ((~v + 1) << `WIDTH_FIX_FRAC);
            _fix_from_int = ~_fix_from_int + 1;
        end
        else
            _fix_from_int = (v << `WIDTH_FIX_FRAC);
    end
endfunction 

function automatic fix_t _fix_mul(
    input fix_t a,
    input fix_t b
    );
    logic [`WIDTH_FIX * 2 - 1:0] T, RA, RB;	
    fix_t TT;
    logic S1, S2;
    //reg Fixed RA, RB;
    
    begin
        S1 = a[`WIDTH_FIX-1];
        S2 = b[`WIDTH_FIX-1];

        RA = (S1) ? ({{`WIDTH_FIX{1'b0}}, ~a + 1}) : {{`WIDTH_FIX{1'b0}}, a};
        RB = (S2) ? ({{`WIDTH_FIX{1'b0}}, ~b + 1}) : {{`WIDTH_FIX{1'b0}}, b};		
        T = (RA * RB) >> `WIDTH_FIX_FRAC;           
        TT = T[`WIDTH_FIX-1:0];
        _fix_mul = (S1 ^ S2) ? (~TT + 1) : TT;		                    
    end    
endfunction

//function automatic fix3_t _fix3(
//    input [`WIDTH_FIX - 1] x, y, z
//    );
    
//    begin
//        _fix3.x = _fix(x);
//        _fix3.z = _fix(y);
//        _fix3.y = _fix(z);
//    end
//endfunction

//function automatic fix_t _fix_zero;
//    _fix_zero = _fix(0);
//endfunction

//function automatic fix_t _fix_unit;
//    _fix_zero = _fix(1);
//endfunction

`endif  
