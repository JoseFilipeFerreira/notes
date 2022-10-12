#version 330

uniform sampler2D tex;
uniform float shininess = 128;

in Data {
	vec4 eye;
	vec2 texCoord;
	vec3 normal;
	vec3 l_dir;
} DataIn;

out vec4 colorOut;

void main() {

	// get texture color
	colorOut = texture(tex, DataIn.texCoord);
}