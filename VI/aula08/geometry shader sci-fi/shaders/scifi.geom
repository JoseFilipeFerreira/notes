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

uniform mat4 m_p;
uniform float scale = 0.2;
uniform float timer;

void main() {

  vec3 tri_normal = normalize(cross(vec3(gl_in[0].gl_Position - gl_in[1].gl_Position), vec3(gl_in[0].gl_Position - gl_in[2].gl_Position)));

  for(int i = 0; i < 3; i++)
  {
     // copy attributes
    float s = scale * (1 + sin(timer/10000));
    s =  scale * max(0, cos(timer/1000)/max(0.000001, sin(timer/1000)));
    s =  scale * max(0, tan(timer/1000));
    gl_Position = m_p * (gl_in[i].gl_Position + vec4(tri_normal * s, 1));
    DataOut.normal = DataIn[i].normal;
    DataOut.lightDir = DataIn[i].lightDir;
 
    // done with the vertex
    EmitVertex();
  }
  EndPrimitive();
}
