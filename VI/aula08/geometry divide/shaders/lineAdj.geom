#version 420
 
layout(triangles) in;
layout (triangle_strip) out;

uniform mat4 PVM;


 void main() {
 
     // copy position
    gl_Position = PVM * gl_in[0].gl_Position;
    EmitVertex();
 
    gl_Position = PVM * gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = PVM * ((gl_in[2].gl_Position + gl_in[0].gl_Position));
    EmitVertex();

    gl_Position = PVM * gl_in[2].gl_Position;
    EmitVertex();
	
	EndPrimitive();

}
