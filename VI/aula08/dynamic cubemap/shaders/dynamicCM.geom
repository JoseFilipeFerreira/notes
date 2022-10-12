#version 330
 
layout(triangles) in;
layout (triangle_strip, max_vertices=18) out;

uniform mat4 P;
uniform mat4 M;

uniform vec4 spherePos;
uniform vec4 lightDir;

in DataV {
	vec3 normal;
	vec2 texCoord;
	int id;
} DataIn[];

out Data {
	vec3 normal;
	vec4 eye;
	vec4 lightDir;
	vec2 texCoord;
	vec4 diffuse;
} DataOut;

 void main() {

	mat4 v[6];

	v[0]=  // POS X
				  
				  mat4( 0, 0, -1, 0, 
				        0, -1, 0, 0,
				        -1, 0, 0, 0,
				        spherePos.z, spherePos.y, spherePos.x, 1);
				//  mat4( 0, 0, 1, -camPos.z, 
				//        0, 1, 0, -camPos.y,
				//       -1, 0, 0, camPos.x,
				//        0, 0, 0, 1);
						
	v[1]= 			  // NEG X
				  mat4( 0, 0, 1, spherePos.x, 
				        0,-1, 0, spherePos.y,
				        1, 0, 0, spherePos.z,
				        -spherePos.z, spherePos.y, -spherePos.x, 1),
				  //mat4( 0, 0, 1,-camPos.z, 
				  //      0,-1, 0, camPos.y,
				  //      1, 0, 0,-camPos.x,
				  //      0, 0, 0, 1);
				  // POS Y
	//v[2]= 			  mat4( 0, 1, 0, 0, 
	//			            0, 0,-1, 0,
	//			           -1, 0, 0, 0,
	//			            0, 0, 0, 1);
	v[2]=   mat4( 1, 0, 0, 0, 
				            0, 0, -1, 0,
			  	            0,1, 0, 0,
				            -spherePos.x, spherePos.z, spherePos.y, 1);
				  // NEG Y
	v[3]=             mat4( 1, 0, 0,0, 
				            0, 0, 1, 0,
				            0, -1, 0,0,
				            spherePos.x, spherePos.z, -spherePos.y, 1);
				  // POS Z
	v[4]= 			  mat4( 1, 0, 0, -spherePos.x, 
				            0,-1, 0, -spherePos.y,
				            0, 0,-1, -spherePos.z,
				            -spherePos.x, spherePos.y, spherePos.z, 1);
				  // NEG Z
	v[5]= 			  mat4(-1, 0, 0, -spherePos.x, 
				            0,-1, 0, -spherePos.y,
				            0, 0, 1, -spherePos.z,
				           spherePos.x, spherePos.y, -spherePos.z, 1);


	mat4 vm;
	vec4 ldCS;
	

	for (int i = 0; i < 6; ++i) {

		if (DataIn[0].id == 0)
			DataOut.diffuse = vec4(1,0,0,0);
		else if (DataIn[0].id == 1)
			DataOut.diffuse = vec4(0,1,0,0);
		else if (DataIn[0].id == 2)
			DataOut.diffuse = vec4(0,0,1,0);
		else if (DataIn[0].id == 3)
			DataOut.diffuse = vec4(1,1,0,0);
		
		gl_Layer = i;
		vm =  v[i] * M;
		ldCS = v[i] * lightDir;
		// first vertex
		gl_Position = P * vm * gl_in[0].gl_Position;
		DataOut.normal = normalize(vec3(vm * vec4(DataIn[0].normal,0)));
		DataOut.eye = - vm *  gl_in[0].gl_Position;
		DataOut.texCoord = DataIn[0].texCoord;
		DataOut.lightDir = ldCS;
		EmitVertex();

		// second
		gl_Position = P * vm * gl_in[1].gl_Position;
		DataOut.normal = normalize(vec3(vm * vec4(DataIn[1].normal,0)));
		DataOut.eye = - vm *  gl_in[1].gl_Position;
		DataOut.texCoord = DataIn[1].texCoord;
		DataOut.lightDir = ldCS;
		EmitVertex();

		// third vertex
		gl_Position = P * vm * gl_in[2].gl_Position;
		DataOut.normal = normalize(vec3(vm * vec4(DataIn[2].normal,0)));
		DataOut.eye = - vm *  gl_in[2].gl_Position;
		DataOut.texCoord = DataIn[2].texCoord;
		DataOut.lightDir = ldCS;
		EmitVertex();

		EndPrimitive();
	}
}

