#version 330

in vec4 position;
in vec3 normal;

uniform mat4 pvm;
uniform mat3 normalM;
uniform mat4 VM;

out vec3 p;
out vec3 n;

void main(){
    gl_Position = pvm*position;
    n = normal(normalM *normal);
    p = VM*position;
}