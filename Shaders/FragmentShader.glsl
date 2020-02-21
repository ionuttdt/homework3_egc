#version 330
 
uniform sampler2D texture_1;
uniform sampler2D texture_2;
 
in vec2 texcoord;



in vec3 world_position;
in vec3 world_normal;

// Uniforms for light properties
uniform vec3 light_direction;
uniform vec3 light_position;
uniform vec3 eye_position;



uniform float material_kd;
uniform float material_ks;
uniform int material_shininess;


layout(location = 0) out vec4 out_color;

void main()
{
	vec4 color1 = texture2D(texture_1, texcoord); 
	vec4 color2 = texture2D(texture_2, texcoord); 

	vec3 V = normalize( eye_position - world_position );
	vec3 L = normalize( light_position - world_position );
	vec3 H = normalize(L + V);
	vec3 N = normalize(world_normal);

	float ambient_light = material_kd * 0.35;
	
	float diffuse_light = material_kd * max(dot(normalize(N),normalize(L)),0);

	float specular_light;
	
	specular_light = 0;
	if (diffuse_light > 0)
	{
		specular_light = material_ks * pow(max(dot(N,H),0), material_shininess);
		
	}
	float d = distance(world_position , light_position);
	

	float atten = 1 / (0.01 * d * d + 0.02 * d + 0.3);
	

	// TODO: compute light
	vec3 light;

	light = color1.xyz * (ambient_light + atten * (diffuse_light + specular_light));

	
	out_color = vec4(light,1);
	//out_color = color1;
}