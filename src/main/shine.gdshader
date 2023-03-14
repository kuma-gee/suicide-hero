shader_type canvas_item;

uniform vec4 shine_color : source_color = vec4(1.0);
uniform float shine_size : hint_range(0.01, 1.0, 0.01) = 0.1;
uniform float shine_speed : hint_range(0.0, 10.0, 0.1) = 1.0;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	
	float slope = tan(radians(100));
    float shine = step(1.0 - shine_size * 0.5, cos(slope * UV.x - UV.y + TIME * shine_speed));
	
	if (COLOR.g > 0.5) {
		COLOR.rgb = mix(COLOR.rgb, shine_color.rgb, shine * shine_color.a);
	}

}
