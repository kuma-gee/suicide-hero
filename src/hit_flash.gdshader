shader_type canvas_item;

uniform float amount: hint_range(0.0, 1.0) = 0.0;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec4 white = vec4(1.0, 1.0, 1.0, 1.0);
	COLOR.rgb = mix(color.rgb, white.rgb, amount);
}