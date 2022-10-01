#version 330

uniform sampler2D tex;
uniform vec4 diffuse;
uniform vec4 otherColor;
uniform float div;

in Data {
	vec2 texCoord;
} DataIn;

out vec4 outputF;

void main() {

	float f = texture(tex, DataIn.texCoord * div).r;
	outputF = mix(diffuse, otherColor, f);
}