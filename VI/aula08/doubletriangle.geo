#version 450
layout(triangles) in;
layout(lines, max_vertices=4) out; // strip com 2 triangulos

uniform mat4 P;

in gl_PerVertex {
    vec4 gl_Postion;
} gl_In[];

in int gl_InvocationID;
in int gl_InstanceID;

in Data{
    vec3 normal;
    vec2 tc;
} DataIn[3];

out Data{
    vec3 normal;
    vec2 tc;
} DataOut;

void main(){
    gl_Postion = P * gl_In[1].gl_Postion;
    EmitVertex();
    gl_Postion = P * (gl_In[1].gl_Postion + gl_In[2].gl_Postion);
    EmitVertex();
    gl_Postion = P * gl_In[0]; EmitVertex();
    gl_Postion = P * gl_In[2]; EmitVertex();
    EndPrimitive();
}