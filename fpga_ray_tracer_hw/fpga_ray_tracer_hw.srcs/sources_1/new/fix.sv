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

function automatic _fix_greater(
    input fix_t a,
    input fix_t b
    );
    logic SA, SB;
    
    begin
        SA = a[`WIDTH_FIX-1];
		SB = b[`WIDTH_FIX-1];

		if (SA ^ SB) begin		
			_fix_greater = (SA) ? 0 : 1;
		end
		else begin
			_fix_greater = (a > b);
		end
    end    
endfunction
//-------------------------------------------------------------------
//
//-------------------------------------------------------------------    
function automatic _fix_greater_equal(
    input fix_t a,
    input fix_t b
    );
    logic SA, SB;
    
    begin
        SA = a[`WIDTH_FIX-1];
		SB = b[`WIDTH_FIX-1];

		if (SA ^ SB) begin		
			_fix_greater_equal = (SA) ? 0 : 1;
		end
		else begin
			_fix_greater_equal = (a >= b);
		end
    end    
endfunction


function automatic _fix_lesser(
    input fix_t a,
    input fix_t b
    );
    logic SA, SB;
    
    begin
        SA = a[`WIDTH_FIX-1];
		SB = b[`WIDTH_FIX-1];

		if (SA ^ SB) begin		
			_fix_lesser = (SA) ? 1 : 0;
		end
		else begin
			_fix_lesser = (a < b);
		end
    end    
endfunction


function automatic _fix_lesser_equal(
    input fix_t a,
    input fix_t b
    );
    logic SA, SB;
    
    begin
        SA = a[`WIDTH_FIX-1];
		SB = b[`WIDTH_FIX-1];

		if (SA ^ SB) begin		
			_fix_lesser_equal = (SA) ? 1 : 0;
		end
		else begin
			_fix_lesser_equal = (a <= b);
		end
    end    
endfunction


function automatic _fix_equal(
    input fix_t a,
    input fix_t b
    );
    begin
        _fix_equal = (a == b);
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
