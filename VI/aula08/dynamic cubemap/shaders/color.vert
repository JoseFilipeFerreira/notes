#version 330

uniform mat4 PVM, VM, V;
uniform mat3 NormalM;
uniform vec4 lightDir;

in vec4 position;
in vec3 normal;
in vec2 texCoord0;

out Data {
	vec3 normal;
	vec4 eye;
	vec4 lightDir;
	vec2 texCoord;
	vec4 diffuse;
} DataOut;


void main()
{
	int row = gl_InstanceID / 2;
	int col = gl_InstanceID % 2;
	
	if (gl_InstanceID == 0)
		DataOut.diffuse = vec4(1,0,0,0);
	else if (gl_InstanceID == 1)
		DataOut.diffuse = vec4(0,1,0,0);
	else if (gl_InstanceID == 2)
		DataOut.diffuse = vec4(0,0,1,0);
	else if (gl_InstanceID == 3)
		DataOut.diffuse = vec4(1,1,0,0);
		
	DataOut.texCoord = texCoord0;
	DataOut.normal = normalize(NormalM * normal);
	DataOut.eye = - VM *  position + vec4(row*4, 0, col*4,0);
	DataOut.lightDir = V * lightDir;

	gl_Position = PVM * (position + vec4(row*4, 0, col*4,0));
} 
