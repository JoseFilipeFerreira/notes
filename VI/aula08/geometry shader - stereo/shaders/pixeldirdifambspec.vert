#version 330

uniform mat4 m_model;

in vec4 position;
in vec4 normal;

out DataV2G {
	vec4 normal;
} DataOut;

void main () {
	// NO NON_UNIFORM SCALES ALLOWED
	DataOut.normal = m_model * normal; // local space
	gl_Position = m_model * position;	// local space
}