#version 330

layout(location = 0) in vec3 v_position;
layout(location = 1) in vec3 v_normal;
layout(location = 2) in vec2 v_texture_coord;
layout(location = 3) in vec3 v_color;

// Uniform properties
uniform mat4 Model;
uniform mat4 View;
uniform mat4 Projection;
uniform float loc;
out vec2 texcoord;

uniform sampler2D texture_1;
uniform sampler2D texture_2;


out vec3 world_position;
out vec3 world_normal;

void main()
{
	texcoord = v_texture_coord ;

	float height = texture2D(texture_2, texcoord).r;

	vec2 texel_size = vec2(1.0/256, 1.0/256);
	float height_right = texture2D(texture_2, vec2(texcoord.x + texel_size.x, texcoord.y)).r;
	float height_up = texture2D(texture_2, vec2(texcoord.x, texel_size.y + texcoord.y)).r;
	float hx = height - height_right;
	float hz = height - height_up;

	vec3 new_normal = normalize(vec3(hx, 1, hz));


	world_position = (Model * vec4(v_position,1)).xyz;
	world_normal = normalize( mat3(Model) * new_normal );

	gl_Position = Projection * View * Model * vec4(vec3(v_position.x, height*5, v_position.z), 1.0);
}