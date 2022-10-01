#version 330

in Data {
	vec2 texCoord;
} DataIn;

out vec4 outputF;

void main() {

	outputF = vec4(DataIn.texCoord, 0 , 1);
}