#version 330

in vec4 position, normal;

uniform mat4 PVM;
uniform mat3 NORMAL;

out vec3 n;

void main () {
	n = normalize(NORMAL * normal);

	gl_Position = PVM * position;

}