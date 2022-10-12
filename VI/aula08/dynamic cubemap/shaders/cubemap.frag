#version 330

uniform samplerCube texUnit; 
//uniform sampler2DArray texUnit;

in vec3 normalV;
in vec3 eyeV;
in vec3 posV;
in vec2 texCoord;

out vec4 outColor;

void main() {

	// normalize vectors
	vec3 n = normalize(normalV);
	vec3 e = normalize(eyeV);

	// compute reflection vector
	vec3 t = reflect(e, n);
		
	// access cube map texture
	vec3 ref = texture(texUnit, t).rgb;

	outColor = vec4(ref, 1.0);
	//outColor = texture(texUnit, vec3(texCoord,0));
}