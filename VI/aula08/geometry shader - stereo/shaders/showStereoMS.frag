#version 450

uniform sampler2DMSArray texUnit;
uniform vec2 vpSize;

in vec2 texCoord;

out vec4 outputF;

void main()
{
	// this function requires version 450
	int samp = textureSamples(texUnit);
	
	vec4 c1 = vec4(0),c2 = vec4(0);
	for (int i = 0 ; i < samp; ++i) {
		c1 += texelFetch(texUnit, ivec3(texCoord*vpSize, 0), i);
		c2 += texelFetch(texUnit, ivec3(texCoord*vpSize, 1), i);
	}
	c1 /= samp;
	c2 /= samp;
	
	outputF = vec4(c1.r, c2.g, c2.b, 1.0);
} 
