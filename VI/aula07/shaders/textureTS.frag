#version 330

uniform sampler2D diffuse, normalMap;

in Data {
	vec2 texCoord;
	vec3 l_dir;
} DataIn;

out vec4 colorOut;

void main() {

	// get texture color
	vec3 texNormal = normalize(vec3(texture(normalMap, DataIn.texCoord) * 2.0 - 1.0));
	
	// normalize both input vectors
	vec3 l = normalize(DataIn.l_dir);
	float intensity = max(dot(texNormal, l), 0.0);

	colorOut = (intensity + 0.4) * texture(diffuse, DataIn.texCoord) ;
}