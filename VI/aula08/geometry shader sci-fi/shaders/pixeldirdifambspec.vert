#version 330

uniform mat4 m_vm, m_view;
uniform mat3 m_normal;

uniform vec4 l_dir;

in vec4 position;
in vec3 normal;

out Data {
	vec3 normal;
	vec3 lightDir;
} DataOut;

void main () {
	DataOut.lightDir = vec3(m_view * (-l_dir));
	DataOut.normal = normalize(m_normal * normal); 
	gl_Position = m_vm * position;	
}