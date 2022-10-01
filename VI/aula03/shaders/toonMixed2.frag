#version 150

uniform	vec4 diffuse;
uniform mat4 m_view;
uniform vec4 l_dir; // global space

in vec3 normalV;

out vec4 outputF;

void main() {

	// get light dir in camera space
	vec3 ld = normalize(vec3(m_view * -l_dir));

	// compute the intensity using the dot operation
	float intensity = max(0, dot(normalV, ld));

	// compute the color based on the intensity
	if (intensity > 0.90)
		outputF = diffuse;
	else if (intensity > 0.75)
		outputF = 0.75 * diffuse;
	else if (intensity > 0.5)
		outputF = 0.5 * diffuse;
	else if (intensity > 0.25)
		outputF = 0.25 * diffuse;
	else
		outputF = 0.1 * diffuse;
		
}
