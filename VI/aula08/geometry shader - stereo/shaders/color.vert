#version 330

uniform mat4 m_pvm;
uniform mat4 m_proj;
uniform mat4 m_model;

in vec4 position;
in vec2 texCoord;

out vec2 texCoord;

void main()
{
	texCoord = texCoord;
	gl_Position =  m_pvm * position ;
} 
