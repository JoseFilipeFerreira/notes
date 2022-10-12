#version 150

uniform	mat4 m_pvm;
uniform	mat3 m_normal;

in vec4 position;
in vec3 normal;

out vec3 normalV;

void main() {
	// transform and normalise both vectors
	normalV = normalize(m_normal * normal);

	gl_Position = m_pvm * position;
}