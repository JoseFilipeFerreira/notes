#version 330

uniform mat4 PVM;
uniform mat4 M;
uniform vec3 camWorldPos; // world space


in vec4 position; // local space
in vec4 normal;	  // local space
in vec2 texCoord0;

out vec3 normalV;
out vec3 eyeV;
out vec3 posV;
out vec2 texCoord;

void main () {

	mat4 m = inverse(transpose(M));
	// compute normal in world space
	normalV = normalize(vec3(m * normal));
	// compute position in world space
	posV = vec3(M * position);
	// compute look direction in world space
	eyeV = posV - camWorldPos;

	texCoord = texCoord0;
	gl_Position = PVM * position;	
}