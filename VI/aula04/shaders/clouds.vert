#version 330

in vec4 position; //
in vec3 normal;   // espaco camera
in vec2 texCoord; //

uniform mat4 pvm;
uniform mat4 view_model;
uniform mat4 view;
uniform vec4 lightDir; //world space
uniform mat3 m_normal;

out vec3 n, pos, lDir; //camera
out vec2 tc;

void main(){
    tc = texCoord;
    n = normalize(m_normal * normal);

    pos = view_model * position;

    gl_Position = pvm * position;

    lDir = view * lightDir;
}