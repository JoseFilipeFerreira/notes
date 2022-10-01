#version 330

layout(triangles) in;
layout (triangle_strip, max_vertices=3) out;

in Data {
	vec3 normal;
	vec3 lightDir;
} DataIn[3];

out Data {
	vec3 normal;
	vec3 lightDir;
} DataOut;

void main() {

  for(int i = 0; i < 3; i++)
  {
     // copy attributes
    gl_Position = gl_in[i].gl_Position;
    DataOut.normal = DataIn[i].normal;
    DataOut.lightDir = DataIn[i].lightDir;
 
    // done with the vertex
    EmitVertex();
  }
  EndPrimitive();
}
