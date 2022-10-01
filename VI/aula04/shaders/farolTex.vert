#version 330

in vec4 position;
in vec3 normal;

uniform mat4 pvm, view, model;
uniform mat3 m_normal;
uniform vec4 lightPos;
uniform vec4 lightDir;


out vec3 n,lpos,vpos;
out vec3 ldir;
out vec2 texCoord;

void main(){
    n = normalize(m_normal * normal);
    vpos = view * ( model * position);
    lpos = view * lightPos;
    ldir = view * lightDir;

    texCoord = 

    gl.Position = pvm * position
}