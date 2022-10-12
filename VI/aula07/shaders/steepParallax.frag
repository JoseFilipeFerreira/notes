#version 150

uniform sampler2D diffuse, normalMap;

uniform float bumpScale = 0.05;

uniform int linSteps = 40;
uniform int binSteps = 8;

uniform int shadowLinSteps = 10;
uniform int shadowBinSteps = 8;

in Data {
	vec3 lightDir, eye;
	vec2 texCoord;
} DataIn;

out vec4 colorOut;

void main() {

	float height = 0.0;
	float steps = linSteps;

	vec2 offset = DataIn.texCoord;
	float h = texture(normalMap, DataIn.texCoord).a;

	vec3 eye = normalize(DataIn.eye);
	steps = mix(steps*2, steps, eye.z);

	float step = 1.0 / steps;
	vec2 delta = - vec2(eye.x, eye.y) * bumpScale / (eye.z * steps);

	while(h > height) {
		height += step;
		offset += delta;
		h = texture(normalMap, offset).a;
	}
	vec2 after = offset;
	vec2 before = offset - delta;
	vec2 middle;
		height += step*0.5;
	for (int i = 0; i < binSteps; ++i) {
		middle = before + (after - before)* 0.5;
		step *= 0.5;
		h = texture(normalMap, middle).a;
		if (h > height) {
			height += step;
			after = middle;
		}
		else {
			height -= step;
			before = middle;
		}
		
	}

	vec4 color = texture(diffuse, offset);
	
	vec3 n = normalize(texture(normalMap, offset).rgb * 2.0 - 1.0);
	vec3 ld = normalize(DataIn.lightDir);
	
	float selfShadow = 0.0;

	float intensity = max(dot(ld, n), 0.0);
	if (intensity > 0.0) {
	
		int shadowSteps = shadowLinSteps;
		step = 1.0 / shadowSteps;
		delta = vec2(ld.x, ld.y) * bumpScale / (ld.z * shadowSteps);

		height = h - step*0.1;

		while (h > height && height > 0) {
		
			height -= step;
			offset += delta;
			h = texture(normalMap, offset).a;
		}
		vec2 after = offset;
		vec2 before = offset - delta;
		vec2 middle;
		height -= step*0.5;
		for (int i = 0; i < shadowBinSteps; ++i) {
			middle = before + (after - before)* 0.5;
			step *= 0.5;
			h = texture(normalMap, middle).a;
			if (h < height) { 
				height += step;
				after = middle;
			}
			else {
				height -= step;
				before = middle;
			}	
		}

		if (height > 0)
			selfShadow = 0.0;
		else
			selfShadow = 1.0;
	}

	colorOut = (vec4(intensity * selfShadow) + vec4(0.4)) * color ;
}