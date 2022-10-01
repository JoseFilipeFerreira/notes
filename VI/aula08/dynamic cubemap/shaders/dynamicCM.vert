#version 330

in vec4 position;
in vec3 normal;
in vec2 texCoord0;

out DataV {
	vec3 normal;
	vec2 texCoord;
	int id;
} DataOut;

void main()
{
	int row = gl_InstanceID / 2;
	int col = gl_InstanceID % 2;
	DataOut.texCoord = texCoord0;
	DataOut.normal = normal;
	DataOut.id = gl_InstanceID;
	gl_Position = position + vec4(row*4, 0, col*4,0);
} 
