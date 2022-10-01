#version 420

uniform sampler2DArray texUnit;

in vec2 texCoord;

out vec4 outputF;

void main()
{
	vec4 cf1 = texture(texUnit, vec3(texCoord, 0));
	vec4 cf2 = texture(texUnit, vec3(texCoord, 1));
	outputF = vec4(cf1.r, cf2.g, cf2.b, 1.0);
} 
