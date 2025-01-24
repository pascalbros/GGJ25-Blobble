shader_type canvas_item;

uniform vec4 color_gap : source_color = vec4(0.25, 0.25, 0.25, 1.0);
uniform vec4 color_stripe : source_color = vec4(1.0, 0.75, 0.0, 1.0);
uniform float divisions : hint_range(1.0, 20.0) = 8.0; // Increase for more stripe density
uniform float stripe_bias : hint_range(1.0, 5.0) = 2.5; // 1.0 = no stripes, 2.0 = equal stripes and gaps
uniform float speed : hint_range(0.0, 5.0) = 0.1;
uniform float angle : hint_range(0.0, 6.28319) = 0.7854; // Angle in radians (0 to 2π)

void fragment() {
    float w = cos(angle) * UV.x + sin(angle) * UV.y - speed * TIME;
    if (fract(w * divisions) * stripe_bias < 1.0) {
        COLOR = color_gap;
    } else {
        COLOR = color_stripe;
    }
}