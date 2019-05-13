#version 140

in vec4 v_color;
in vec2 v_tex_coord;

uniform mat4 u_projTrans;
uniform sampler2D u_texture;

out vec4 pixel;

uniform float glow_size;
uniform vec3 glow_colour;
uniform float glow_intensity;
uniform float glow_threshold;

void main() {
    pixel = texture(u_texture, v_tex_coord);
    if (pixel.a <= glow_threshold) {
        ivec2 size = textureSize(u_texture, 0);

        float uv_x = v_tex_coord.x * size.x;
        float uv_y = v_tex_coord.y * size.y;

        float sum = 0.0;
        for (int n = 0; n < 9; ++n) {
            uv_y = (v_tex_coord.y * size.y) + (glow_size * float(n - 4.5));
            float h_sum = 0.0;
            h_sum += texelFetch(u_texture, ivec2(uv_x - (4.0 * glow_size), uv_y), 0).a;
            h_sum += texelFetch(u_texture, ivec2(uv_x - (3.0 * glow_size), uv_y), 0).a;
            h_sum += texelFetch(u_texture, ivec2(uv_x - (2.0 * glow_size), uv_y), 0).a;
            h_sum += texelFetch(u_texture, ivec2(uv_x - glow_size, uv_y), 0).a;
            h_sum += texelFetch(u_texture, ivec2(uv_x, uv_y), 0).a;
            h_sum += texelFetch(u_texture, ivec2(uv_x + glow_size, uv_y), 0).a;
            h_sum += texelFetch(u_texture, ivec2(uv_x + (2.0 * glow_size), uv_y), 0).a;
            h_sum += texelFetch(u_texture, ivec2(uv_x + (3.0 * glow_size), uv_y), 0).a;
            h_sum += texelFetch(u_texture, ivec2(uv_x + (4.0 * glow_size), uv_y), 0).a;
            sum += h_sum / 9.0;
        }
        pixel = vec4(glow_colour, (sum / 9.0) * glow_intensity);
    }
}
