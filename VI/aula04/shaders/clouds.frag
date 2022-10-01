#version 330

uniform sampler2D eDay;
uniform sampler2D eNight;
uniform sampler2D eSpec;
uniform sampler2D eClouds;

uniform float shininess;

in vec3 n, pos, lDir;
in vec2 tc;

void main(){
    vec4 cDay = texture(eDay, tc);
    vec4 cNight = texture(eNight, tc);
    float cSpec = texture(eSpec, tc).r;
    float cClouds = texture(eClouds, tc).r;

    vec4 spec = vec4(0);

    float i = max(0, dot(normalize(lDir), normalize(n)));

    if (i>0){ //dia
        vec3 h = normalize(normalize(lDir) + normalize(-pos)); //como estamos no espaco camera o vetor que aponta para a camera e o inverso de pos

        spec = power(dot(normalize(n), h), shininess);
    }

    float f = smoothstep(0.9, 1, 1-i); // mudanca suave entre os valores 0.9 e 1, se passar para alem de um deles salta para 0 ou 1

    vec4 cor = mix(cDay, cNight, f); // misturar as duas texturas com cDay * f + cNight * (1-f)

    if (i>0) //dia
        cor = cor + cClouds; // ficar mais branco quanto mais opaca a nuvem
    else
        cor = cor * (1- cClouds); //bloquear mais quanto mais opaca a nuvem

    cOut = max(i,0.25) * cor + spec * cSpec;
}