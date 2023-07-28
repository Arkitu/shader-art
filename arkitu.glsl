#include "utils.glsl"

const float PI = 3.1415926535897932384626433832795;

const float X_SPACING = .3;

/*

fragColor : output (r, g, b, a)
fragCoor : position du pixel (x, y)
iTime : timestamp actuel en secondes
iResolution : résolution de l'écran

*/

vec2 space( in vec2 p, in float spacing) {
    return vec2(p[0]-(spacing*X_SPACING), p[1]);
}

float A( in vec2 p, in float spacing ) {
    return step(sdEquilateralTriangle(space(p, spacing), .1), .02);
}

float R( in vec2 p, in float spacing ) {
    float i = 0.;

    // Upper body
    vec2 mod_p = space(p, spacing) + vec2(0., -.08);
    mod_p = vec2(mod_p[1], mod_p[0]);
    i += step(sdTunnel(mod_p, vec2(.04, .06)), .02);

    // Foot
    mod_p = space(p, spacing) + vec2(.06, .06);
    mod_p = rotate(mod_p, PI/4.);
    i += step(sdTriangleIsosceles(mod_p, vec2(.07)), .02);

    return min(i, 1.);
}

float K( in vec2 p, in float spacing ) {
    float i = 0.;

    // Upper body
    vec2 mod_p = space(p, spacing) + vec2(.08, -.12);
    mod_p = rotate(mod_p, 3.*PI/4.);
    i += step(sdTriangleIsosceles(mod_p, vec2(.07)), .02);

    // Foot
    mod_p = space(p, spacing) + vec2(.08, .06);
    mod_p = rotate(mod_p, PI/4.);
    i += step(sdTriangleIsosceles(mod_p, vec2(.07)), .02);

    return min(i, 1.);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from -1 to 1)
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;

    vec3 baseColor = palette(iDate[3]);

    float i = 0.;

    i += A(uv, -2.5);

    i += R(uv, -1.5);

    i += K(uv, -.5);

    fragColor = vec4(baseColor*i, 1.);
}