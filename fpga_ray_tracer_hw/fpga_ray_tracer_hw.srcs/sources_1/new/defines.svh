`ifndef DEFINES_SV
`define DEFINES_SV

// scene render properties
`define ASPECT_RATIO    16/9
`define IMAGE_HEIGHT    90
`define IMAGE_WIDTH     160
`define SAMPLES_PER_PX  10
`define MAX_BOUNCES     5

`define VIEWPORT_HEIGHT 1.8
`define VIEWPORT_WIDTH  3.2
`define PIXEL_DELTA_H   `VIEWPORT_HEIGHT/`IMAGE_HEIGHT
`define PIXEL_DELTA_W   `VIEPORT_WIDTH/`IMAGE_WIDTH
// viewport upper left = (-vw/2, wh/2, 1) 


// fixed point parameters
// for Q18.14 fixed point; 1 sign, 17 integer and 14 fraction bits
`define WIDTH_FIX       32
`define WIDTH_FIX_INT   17
`define WIDTH_FIX_FRAC  14
`define SIZE_FIX        [`WIDTH_FIX - 1: 0]

// raw 32 bit floating point datatype
typedef logic `SIZE_FIX fix_t;

// vec3 struct containg 3 floats as {x, y, z}
typedef struct packed {
    fix_t x;
    fix_t y;
    fix_t z;
} fix3_t;

// ray type
typedef struct packed {
    fix3_t origin;
    fix3_t dirn;
} ray_t;

//// color data type, a vec3 interpreted as {r, g, b} 
//typedef vec3_t color_t;

`endif