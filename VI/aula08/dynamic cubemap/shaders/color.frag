#version 330


uniform sampler2D texUnit;

in Data {
	vec3 normal;
	vec4 eye;
	vec4 lightDir;
	vec2 texCoord;
	vec4 diffuse;
} DataIn;


out vec4 outputF;

void main() {

	vec4 spec = vec4(0.0);

	vec3 n = normalize(DataIn.normal);
	vec3 e = normalize(vec3(DataIn.eye));
	vec3 l = normalize(vec3(DataIn.lightDir));

	float intensity = max(dot(n,l), 0.0);

	if (intensity > 0.0) {
		vec3 h = normalize(l + e);	
		float intSpec = max(dot(h,n), 0.0);
		spec = vec4(1) * pow(intSpec,128);
	}
	vec4 color =  max(intensity *  DataIn.diffuse, 0.25 * DataIn.diffuse);
	color.a = DataIn.diffuse.a;

	outputF = color + spec;
}