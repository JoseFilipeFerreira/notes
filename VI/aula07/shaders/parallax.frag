#version 330

uniform sampler2D diffuse, normalMap;
uniform float scale = 0.04, bias = 0.0;

in Data {
	vec3 lightDir, eye;
	vec2 texCoord;
} DataIn;

out vec4 colorOut;

void main() {

	float h = texture(normalMap, DataIn.texCoord).a;
	h = h * scale - bias;

	vec3 eye = normalize(DataIn.eye);
	vec2 texCoord = DataIn.texCoord + h * vec2(eye.x, eye.y);

	vec3 n = normalize(texture(normalMap, texCoord).rgb * 2.0 - 1.0);

	float intensity = max(dot(normalize(DataIn.lightDir), n), 0.0);

	colorOut = (vec4(intensity) + vec4(0.4)) * texture(diffuse, texCoord)  ;
}