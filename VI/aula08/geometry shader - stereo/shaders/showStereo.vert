#version 330

in vec4 position;
in vec2 texCoord0;

out vec2 texCoord;

void main()
{
	texCoord = texCoord0;
	gl_Position = position ;
} 
