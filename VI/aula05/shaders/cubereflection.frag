#version 330
in vec3 n,p;

out vec4 cOut;

uniform samplerCube tex;

void main(){
    vec3 e = normalize(p - vec3(0));
    vec3 nm = normalize(n);
    vec3 r = refelct(e, nm);
    cOut = texture(tex, r);
}