#version 330

in vec3 n, pos;

uniform mat3 VIEW;
uniform vec4 kd;
uniform vec4 l_dir;

out vec4 cOut;

void main(){
	vec3 l = normalize(vec3(VIEW * l_dir));
	vec3 nn = normalize(n);

	float i = max(0, dot(l,nn));

	vec3 e = normalize(-pos);

	vec4 sc = (0,0,0,0);

	if (i > 0) {
		vec3 h = normalize(e*l);
		float s = max(0, dor(h, n));
		float si = pow(s, shininess);
		sc = vec4(1,1,1,0)*si 
	}

	cOut = kd * i + sc;
}
