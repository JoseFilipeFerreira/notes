#version 330

uniform vec4 diffuse;
uniform vec4 otherColor;
uniform float div;
uniform float width;
uniform float gap = 0.04;

in Data {
	vec2 texCoord;
} DataIn;

out vec4 outputF;

/*void main() {

	vec2 tc = DataIn.texCoord * div;
	float fr = fract(tc.s);
	
	// color 1
	if (fr < width - gap)
		outputF = diffuse;
	
	// transition from color 1 to color 2
	else if (fr < width )
		outputF = mix(diffuse, otherColor, (fr - width + gap) * (1.0/ gap));
	
	// color 2	
	else if (fr < 1.0 - gap)
		outputF = otherColor;
		
	// transition from color2 to color 1
	else	
		outputF = mix(otherColor, diffuse, (fr - 1.0 + gap) * (1.0/ gap));
}
*/
void main() {

	vec2 tc = DataIn.texCoord * div;
	float fr = fract(tc.s);
	
	// color 1
	if (fr < width - gap )
		outputF = diffuse;
		
	// transition from color 1 to color 2
	else if (fr < width) {
		float f = (fr  - (width - gap)) * 1.0/gap; // fraction
		outputF = mix(diffuse, otherColor, f);
	}
	// color 2
	else if (fr < 1.0 - gap)
		outputF = otherColor;
	
	// transition from color 2 to color 1
	else {
		float f = (fr - (1.0 - gap)) * 1.0/gap; // fraction
		outputF = mix(otherColor, diffuse, f);
	}		
}
