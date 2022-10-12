#version 330

layout(points) in;
layout (triangle_strip, max_vertices=9) out;

uniform sampler2D noise;
uniform mat4 m_pvm;
uniform float timer;



out Data {
	float height;
    float green;
} DataOut;

void main() {

    vec4 p[5];
    float h[5];

    vec4 pos = gl_in[0].gl_Position;
    float base_width = 0.1 + texture(noise, pos.xz * vec2(3.14159, 1.17)).x* 0.1;
    float middle_width =  texture(noise, pos.zx * vec2(2.37,3.14159)).x * 0.15;
    p[0] = -vec4(base_width*0.5, 0,0,0); h[0] = 0.0;
    p[1] = vec4(base_width*0.5, 0,0,0); h[1] = 0.0;
    float middle_height = 2 * texture(noise, pos.zx * 3.14159).x;
    p[2] = vec4(-middle_width*0.5, middle_height,0,0); h[2] = middle_height;
    p[3] = vec4(+middle_width*0.5, middle_height,0,0); h[3] = middle_height;

    float bend = texture(noise, pos.zx * vec2(1.79,3.14159)).x * 0.15;
    p[4] = vec4(0 , middle_height * 1.75, bend,0); h[4] = middle_height * 1.75;



    float c1 = texture(noise, pos.zx * vec2(0.79,14.14159)).x * 2 -1;
    float s =  sqrt(1-c1*c1);
    if ( texture(noise, pos.zx * vec2(0.79, 1.17)).x > 0.5)
        s = -s;
    mat3 randomRot = mat3(c1, 0, -s, 0,1,0, s,0,c1);

    vec2 windDir = vec2(texture(noise, pos.xz * 0.0025 + timer*0.00001).x, texture(noise, pos.zx * 0.0025 + timer*0.00001).x);
    float windSpeed = length(windDir);
    windDir = normalize(windDir);
    vec2 axisRot = vec2(windDir.y, -windDir.x);

    mat3 rotWind = mat3(windDir.x, 0, -windDir.y, 0,1,0,   axisRot.y, 0, axisRot.x);
    mat3 rotWindInv = transpose(rotWind);
    
    float c = windSpeed * 0.1 + 0.8 ;
    s = sqrt(1 - c*c);
    mat3 rotblade = mat3(1,0,0,   0,c,s,   0,-s,c);



    for (int i = 0; i < 5; ++i) {
        p[i].xyz =  rotWindInv* rotblade * rotWind * (randomRot * p[i].xyz);
    }

    for (int i = 0; i < 5; ++i) {
	    gl_Position = m_pvm * (pos + p[i]);
        DataOut.height = h[i];
        DataOut.green = (c1*0.6 + 0.4) * h[i];
	    EmitVertex();
    }   

 
	EndPrimitive();
}
