#version 330

uniform sampler2D texColor;

in vec2 texCoord;

out vec4 outputF;

void main()
{
	outputF = texture(texUnit, texCoord, 0).r +
				texture(texUnit, texCoord, 1).r;
} 
