`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2024 08:16:04 PM
// Design Name: 
// Module Name: prng_fix
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

// this modules is a prng that generates a psuedorandom fixed point number between 0 and 1
// currently hardcoded for Q18.14 fixed point since feedback is not parametrizable yet
`include "defines.svh"

module prng_fix
#(parameter SEED = 14'b00000011011110) (
    input logic gen, rst,
    output fix_t fix_rand
    );
    
    logic [13:0] lfsr_reg;
    
    always_ff @(posedge gen) begin
        if (rst)
            lfsr_reg <= SEED;
        else
            lfsr_reg <= {lfsr_reg[12:0], lfsr_reg[13] ^ lfsr_reg[4] ^ lfsr_reg[2] ^ lfsr_reg[0]};
    end
    
    assign fix_rand = {1'b0, `WIDTH_FIX_INT'b0, lfsr_reg};
    
endmodule
