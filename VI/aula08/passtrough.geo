#version 450
layout(triangles, invocations=3) in;
layout(lines, max_vertices=6) out;

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
    for(int i = 0; i < 3; i++){
        gl_Postion = gl_In[i].gl_Postion;
        DataOut.normal = DataIn[i].normal;
        DataOut.tc = DataIn[i].tc;
        EmitVertex();
    }
    EndPrimitive();
}