//#include "utils.glsl"

const float PI = 3.1415926535897932384626433832795;

//const float CIRCLE_COUNT = 10.;
const float GLOBAL_RADIUS = .5;

/*

fragColor : output (r, g, b, a)
fragCoor : position du pixel (x, y)
iTime : timestamp actuel en secondes
iResolution : résolution de l'écran

*/

//https://iquilezles.org/articles/palettes/
vec3 palette( float t ) {
    vec3 a = vec3(0.388, 0.478, 0.500);
    vec3 b = vec3(-0.122, -0.164, 0.355);
    vec3 c = vec3(0.340, 0.340, 0.340);
    vec3 d = vec3(0.000, 0.333, 0.667);

    return a + b*cos( 6.28318*(c*t+d) );
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float CIRCLE_COUNT = (sin(iTime/2.))*150.;
    // Normalized pixel coordinates (from -1 to 1)
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;

    vec3 baseColor = vec3(1.); /*palette(iTime);*/

    vec3 color = vec3(.0);

    float unitAngle = (2.*PI)/CIRCLE_COUNT;
    for (float i = 0.; i < abs(CIRCLE_COUNT); i++) {
        if (i == 0.) {
            continue;
        }
        float angle = (1.01)*i + unitAngle * i;
        vec2 center = vec2(cos(angle), sin(angle))*GLOBAL_RADIUS;
        float a = (sin(.001/(length(uv-center) - ((sin(iTime+(1.*i)))/10.)))/2.);
        color += baseColor*a;
    }
    

    fragColor = vec4(color, 1.);
}