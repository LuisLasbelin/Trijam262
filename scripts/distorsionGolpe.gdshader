shader_type canvas_item;

uniform sampler2D scrTex : hint_screen_texture;
uniform float amplitud = 1.0; // Esto se modifica/explica en el script
uniform float momento = 0.0; // Esto se modifica/explica en el script
uniform float inicio = 0.0; // Margen del inicio de la mascara, no recomiendo tocarlo
uniform float final = -1.5; // Margen del final de la mascara, no recomiendo tocarlo

void fragment() {
	vec2 uv = UV * 2.0 - 1.0;
	float dist = length(uv);
	vec2 dir = normalize(uv);
	float wave = sin( ((dist - momento) * PI * amplitud) + (3.0 * PI / 2.0) );
	vec2 disp = dir * wave * clamp(1.0 - dist, 0.0, 1.0);
	
	float mom = dist - momento;
	float mask = clamp(1.0 - (mom) + inicio, 0.0, 1.0) - clamp(1.0 - (mom) + final, 0.0, 1.0);
	mask = clamp(mask, 0.0, 1.0);
	
	disp *= mask;
	
//	COLOR.rgb = vec3(dir, 0.0);
//	COLOR.rgb = vec3(wave);
	COLOR.rgb = texture(scrTex, SCREEN_UV + disp * .1).rgb;
//	COLOR.rgb = vec3(wave * mask);
	COLOR.a = 1.0;
}
