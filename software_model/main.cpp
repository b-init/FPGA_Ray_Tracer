#include "rtweekend.h"

#include "camera.h"
#include "hittable.h"
#include "hittable_list.h"
#include "sphere.h"


int main() {

    hittable_list world;

    auto material_ground = make_shared<lambertian>(color(1, 1, 1));
    auto material_center = make_shared<lambertian>(color(1, 1, 1));

    world.add(make_shared<sphere>(point3(0,0,-1), 0.5, material_center));
    world.add(make_shared<sphere>(point3(0,-100.5,-1), 100, material_ground));

    camera cam;

    cam.aspect_ratio      = 16.0 / 9.0;
    cam.image_width       = 600;
    cam.samples_per_pixel = 50;
    cam.max_depth         = 5;

    cam.render(world);
}