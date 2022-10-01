#version 330

uniform vec4 diffuse;
uniform float div;
uniform float width;

in Data {
	vec2 texCoord;
} DataIn;

out vec4 outputF;

void main() {

	vec2 tc = DataIn.texCoord * div;
	
	if (fract(tc.s) < width && fract(tc.t) < width)
		discard;
	outputF = diffuse;
}