#include "utils.glsl"

const float PI = 3.1415926535897932384626433832795;

//const float CIRCLE_COUNT = 10.;
const float GLOBAL_RADIUS = .5;

/*

fragColor : output (r, g, b, a)
fragCoor : position du pixel (x, y)
iTime : timestamp actuel en secondes
iResolution : résolution de l'écran

*/

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float step = iDate[3]/2.;
    float CIRCLE_COUNT = (sin(step))*150.;
    // Normalized pixel coordinates (from -1 to 1)
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;

    vec3 baseColor = palette(iTime);

    vec3 color = vec3(.0);

    float unitAngle = (2.*PI)/CIRCLE_COUNT;
    float stepSin = sin(step);
    for (float i = 0.; i < abs(CIRCLE_COUNT); i++) {
        if (i == 0.) {
            continue;
        }
        float angle = (unitAngle + 1.01) * i;
        float angleSin = sin(angle);
        float angleCos = cos(angle);
        vec2 center = vec2(
            (
                angleSin * stepSin
                 + 
                angleCos * (1.-stepSin)
            ),
            (
                angleSin * (1.-stepSin)
                 + 
                angleCos * stepSin
            )
        )*GLOBAL_RADIUS;
        float a = (sin(50./(length(uv-center) - ((sin(iDate[3]+i))/10.)))/2.)/CIRCLE_COUNT;
        float b = (sin(.01/(length(uv-center) - ((sin(iDate[3]+i))/10.)))/2.);

        color += palette(i/CIRCLE_COUNT)*a*b*500.;
    }


    fragColor = vec4(color, 1.);
}