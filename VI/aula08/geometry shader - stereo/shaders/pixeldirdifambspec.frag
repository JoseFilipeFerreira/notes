#version 420

uniform	vec4 diffuse = vec4(1.0);;
uniform float shininess = 128;

in Data {
	vec3 normal;
	vec3 eye;
	vec3 lightDir;
} DataIn;

out vec4 colorOut;

void main() {

	vec4 spec = vec4(0.0);

	vec3 n = normalize(DataIn.normal);
	vec3 l = normalize(DataIn.lightDir);
	vec3 e = normalize(DataIn.eye);

	float intensity = max(dot(n,l), 0.0);

	if (intensity > 0.0) {
		vec3 h = normalize(l + e);	
		float intSpec = max(dot(h,n), 0.0);
		spec = vec4(1.0) * pow(intSpec, shininess);
	}

	colorOut = max(intensity, 0.25) * diffuse + spec;
}