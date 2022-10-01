#version 330

in vec4 position, normal;

uniform mat4 PVM, VIEW_MODEL;
uniform mat3 NORMAL;

uniform vec4 l_dir;

out vec3 n, pos;

void main () {
	n = normalize(NORMAL * normal);

	gl_Position = PVM * position;

	pos = vec3(VIEW_MODEL * position)

}