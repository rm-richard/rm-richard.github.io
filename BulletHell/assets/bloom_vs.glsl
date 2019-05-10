#version 140

in vec2 a_position;
in vec2 a_texCoord0;
in vec4 a_color;

uniform mat4 u_projTrans;

out vec4 v_color;
out vec2 v_tex_coord;

void main() {
   v_color = a_color;
   v_tex_coord = a_texCoord0;
   gl_Position = u_projTrans * vec4(a_position, 0, 1);
}