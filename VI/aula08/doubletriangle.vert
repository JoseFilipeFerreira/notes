in vec4 position;
uniform mat4 VM;
void main(){
    gl_Position = VM*position;
}