#version 330

in vec3 n;
uniform mat3 VIEW;
uniform vec4 kd;
uniform vec4 l_dir;

out vec4 cOut;

void main(){
	vec3 l = normalize(vec3(VIEW * l_dir));
	vec3 nn = normalize(n);

	float i = max(0, dot(l,nn));

//	if (i < 0.3)
//		i = 0.1;
//	else if (i < 0.6)
//		i = 0.4;
//	else if (i < 0.9)
//		i = 0.7;
//	else
//		i = 1.0; 

	cOut = kd * i;
}
