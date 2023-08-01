#include "utils.glsl"

const float PI = 3.1415926535897932384626433832795;
/*

fragColor : output (r, g, b, a)
fragCoor : position du pixel (x, y)
iTime : timestamp actuel en secondes
iResolution : résolution de l'écran

*/

const float SQUARE_COUNT = 8.;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 p = (((fragCoord * 2.0 - iResolution.xy) / iResolution.y)+1.)/2.;

    vec2 cell = vec2(floor(p*SQUARE_COUNT)/SQUARE_COUNT);

    float angle = random(cell)*2.*PI;

    vec2 rel_p = (p - cell)*SQUARE_COUNT;

    vec2 arrow = vec2(cos(angle), sin(angle)) + .5;

    //vec3 color = vec3(rel_p, 0.);

    vec3 color = vec3(distance(rel_p, arrow)-.5);

    color = vec3(dot(arrow-.5, rel_p-.5) + .5);

    //color = vec3(cell, 0.);

    //color = vec3(rel_p, 0.);

    //color = vec3(angle/(2.*PI));

    fragColor = vec4(color, 1.);
}