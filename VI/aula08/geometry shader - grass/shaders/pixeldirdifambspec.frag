#version 420

uniform	vec4 diffuse = vec4(1.0);

in Data {
	float height;
	float green;
} DataIn;

out vec4 colorOut;

void main() {

	colorOut = vec4(0,0.3 + DataIn.green,0,0);
}