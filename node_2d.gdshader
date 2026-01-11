shader_type canvas_item;

uniform float current_value : hint_range(0.0, 1.0) = 1.0;
uniform float lerp_value    : hint_range(0.0, 1.0) = 1.0;

uniform vec4 front_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform vec4 back_color  : source_color = vec4(0.4, 0.0, 0.0, 1.0);
uniform vec4 bg_color    : source_color = vec4(0.1, 0.1, 0.1, 1.0);

uniform vec4 border_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float border_px = 1.0; // pixels

void fragment() {
    vec2 uv = UV;

    // Pixel → UV
    vec2 px = border_px * TEXTURE_PIXEL_SIZE;

    bool is_border =
        uv.x < px.x || uv.x > 1.0 - px.x ||
        uv.y < px.y || uv.y > 1.0 - px.y;

    if (is_border) {
        COLOR = border_color;

    }
	   // Background first
	    COLOR = bg_color;

	    bool in_back  = uv.x < lerp_value;
	    bool in_front = uv.x < current_value;

	    if (in_back) {
	        COLOR = back_color;
	    }
	    if (in_front) {
	        COLOR = front_color;
	    }
}
