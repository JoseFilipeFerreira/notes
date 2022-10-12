#version 330

uniform vec4 diffuse;
uniform vec4 otherColor;
uniform float div;
uniform float width;
uniform float gap = 0.04;

in Data {
	vec2 texCoord;
} DataIn;

out vec4 outputF;

void main() {

	vec2 tc = DataIn.texCoord * div;
	float fr = fract(tc.s);
	
	float f = smoothstep(width - gap, width, fr) - smoothstep(1.0 - gap, 1.0, fr);	
	outputF = mix(diffuse, otherColor, f);
}