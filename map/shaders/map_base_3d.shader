shader_type spatial;


uniform float sea_level = 0.37;
uniform float mountains_level = 0.39;
uniform float coastline_thickness = 0.02;
uniform float coast_thickness = 0.01;

uniform sampler2D heightmap : hint_white;
uniform sampler2D noise_texture : hint_black;

uniform vec4 coastline_color : hint_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 coast_color : hint_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 mountains_color : hint_color = vec4(0);
uniform vec4 terrain_color : hint_color = vec4(1);
uniform vec4 water_color : hint_color = vec4(0.0, 0.0, 0.4, 1.0);
 
void fragment() {
	vec4 pixel_color = texture(heightmap, UV);
	
	vec4 noise = texture(noise_texture, UV);
	vec4 pre_texture = vec4(0);
	
	if (pixel_color.r > sea_level) 
	{
		if (pixel_color.r > sea_level + coast_thickness)
		{
			pre_texture = terrain_color;
		}
		else
		{
			pre_texture = coast_color;
		}
	}
	else 
	{
		if (pixel_color.r > sea_level - coastline_thickness)
		{
			pre_texture = coastline_color;
		}
		else
		{
			pre_texture = mix(water_color, noise, 0.03);
		}
	}
	if (pixel_color.r > mountains_level)
	{
		pre_texture = mountains_color;
	}
	ALBEDO = pre_texture.rgb;
}
