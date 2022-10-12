#version 330

in vec3 n;
in vec3 lpos, vpos;
in vec3 ldir;

uniform float shininess;
uniform vec4 difuse, specular;
uniform vec3 camera;
uniform float cutOff;

out vec4 cOut;

void main(){
    vec3 l = normalize(lpos - vpos);
    ld = normalize(ldir)

    if (dot(ld, l) > cutOff ) {
        float i = max(0, dot(l, normalize(n)));

        vec4 spec = vec4(0);

        if (i>0){
            vec3 h = normalize(normalize(camera-vpos) + l);
            spec = specular * power(dot(h, normalize(n)), shininess);
        }

        cOut = difuse * (i + 0.25) + spec;

    }
    
    cOut = 0.25 * difuse;
}