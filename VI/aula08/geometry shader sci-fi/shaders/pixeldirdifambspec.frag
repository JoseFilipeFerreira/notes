#version 420

uniform	vec4 diffuse = vec4(1.0);;

in Data {
	vec3 normal;
	vec3 lightDir;
} DataIn;

out vec4 colorOut;

void main() {

	vec4 spec = vec4(0.0);

	vec3 n = normalize(DataIn.normal);
	vec3 l = normalize(DataIn.lightDir);

	float intensity = max(dot(n,l), 0.0);

	colorOut = max(intensity, 0.25) * diffuse;
}