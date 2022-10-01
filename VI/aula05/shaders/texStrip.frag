#version 330

uniform vec4 diffuse;
uniform vec4 otherColor;
uniform float div;
uniform float width;

in Data {
	vec2 texCoord;
} DataIn;

out vec4 outputF;

void main() {

	vec2 tc = DataIn.texCoord * div;

	float fr = fract(tc.s);
	
	if (fr < width )
		outputF = diffuse;
	else
		outputF = otherColor;

}