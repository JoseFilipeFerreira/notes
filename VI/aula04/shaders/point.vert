#version 330

in vec4 position;
in vec3 normal;

uniform mat4 pvm, view, model;
uniform mat3 m_normal;
uniform vec4 lightPos;

out vec3 n,lpos,vpos;

void main(){
    n = normalize(m_normal * normal);
    vpos = view * ( model * position);
    lpos = view * lightPos;

    gl.Position = pvm * position
}