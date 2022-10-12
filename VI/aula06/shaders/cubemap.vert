#version 330

uniform mat4 PVM;
uniform mat4 M;
uniform vec3 camWorldPos; // world space


in vec4 position; // local space
in vec4 normal;	  // local space

out vec3 normalV;
out vec3 eyeV;

void main () {
	// compute normal in world space
	normalV = normalize(vec3(M * normal));
	// compute position in world space
	vec3 pos = vec3(M * position);
	// compute look direction in world space
	eyeV = normalize(pos - camWorldPos);

	gl_Position = PVM * position;	
}