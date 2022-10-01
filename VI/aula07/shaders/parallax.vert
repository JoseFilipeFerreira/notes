#version 330

uniform	mat4 m_pvm;
uniform	mat4 m_view;
uniform	mat4 m_viewModel;
uniform	mat3 m_normal;

uniform vec4 l_dir;

in vec4 position;
in vec3 normal, tangent;
in vec2 texCoord0;

out Data {
	vec3 lightDir, eye;
	vec2 texCoord;
} DataOut;

void main () {
	
	DataOut.texCoord = texCoord0;

	vec3 n = normalize(m_normal * normal);
	vec3 t = normalize(m_normal * tangent);
	vec3 b = cross(n, t);

	mat3 TBN = mat3(t, b, n);

	DataOut.lightDir = transpose(TBN) * vec3(-m_view * l_dir);

	vec3 eye = vec3(m_viewModel * position);

	DataOut.eye = transpose(TBN) * eye;

	gl_Position = m_pvm * position;	
}