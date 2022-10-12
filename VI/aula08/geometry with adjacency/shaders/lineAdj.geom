#version 420
 
layout(triangles_adjacency) in;
layout (line_strip, max_vertices=6) out;

uniform	mat4 PVM;
uniform mat4 M;

uniform vec3 camPos;

// Explore culling option

 void main()
{


	vec3 ps[6];
	for (int i = 0; i < 6; ++i)
		ps[i] = vec3(M * gl_in[i].gl_Position);
		
	vec3 c = normalize(camPos - (ps[0]+ps[2]+ps[4])/3) ; 
	vec3 c2 = normalize(camPos - (ps[0]+ps[2]+ps[1])/3) ; 
	vec3 c4 = normalize(camPos - (ps[0]+ps[4]+ps[5])/3) ; 
	vec3 c6 = normalize(camPos - (ps[2]+ps[5]+ps[5])/3) ; 
	
	vec3 edge1 = ps[1] - ps[0];
	vec3 edge2 = ps[2] - ps[0];
	vec3 edge3 = ps[4] - ps[0];
	vec3 edge4 = ps[5] - ps[0];
	vec3 edge5 = ps[4] - ps[2];
	vec3 edge6 = ps[3] - ps[2];

	vec4 pf[3];
	pf[0] = PVM * gl_in[0].gl_Position;
	pf[1] = PVM * gl_in[2].gl_Position;
	pf[2] = PVM * gl_in[4].gl_Position;
	
	// triangle normal
	vec3 n = normalize(cross(edge2, edge3));
	
	// neighbour normals
	vec3 n2 = normalize(cross(edge1, edge2));
	vec3 n4 = normalize(cross(edge3, edge4));
	vec3 n6 = normalize(cross(edge6, edge5));

	if (dot(n, c) < 0)
		return;
		
/*	if (dot(c2,n2) < 0.0 || ps[0] == ps[1]) {
			gl_Position = pf[0];
			EmitVertex();
			gl_Position = pf[1];
			EmitVertex();
			EndPrimitive();
	}
	if (dot(c4,n4) < 0.0 || ps[4] == ps[5]) {
			gl_Position = pf[0];
			EmitVertex();
			gl_Position = pf[2];
			EmitVertex();
			EndPrimitive();
	}
	
	if (dot(c6,n6) < 0.0 || ps[2] == ps[3]) {
			gl_Position = pf[1];
			EmitVertex();
			gl_Position = pf[2];
			EmitVertex();
			EndPrimitive();
	}
*/	
	if (dot(c2,n2) < 0.0 && ps[0] != ps[1]) {
			gl_Position = pf[0];
			EmitVertex();
			gl_Position = pf[1];
			EmitVertex();
			EndPrimitive();
	}
	if (dot(c4,n4) < 0.0 && ps[4] != ps[5]) {
			gl_Position = pf[0];
			EmitVertex();
			gl_Position = pf[2];
			EmitVertex();
			EndPrimitive();
	}
	
	if (dot(c6,n6) < 0.0 && ps[2] != ps[3]) {
			gl_Position = pf[1];
			EmitVertex();
			gl_Position = pf[2];
			EmitVertex();
			EndPrimitive();
	}
	
 }
