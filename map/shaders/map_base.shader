shader_type canvas_item;

uniform float sea_level = 0.37;
uniform float mountains_level = 0.39;
uniform float coastline_thickness = 0.02;
uniform float coast_thickness : hint_range(0.001, 3.0, 0.00001) = 0.001;

uniform sampler2D noise_texture : hint_black;
uniform sampler2D terrain_texture : hint_black;

uniform vec4 coast_color : hint_color = vec4(0., 0., 0., 1.);
uniform vec4 coastline_color : hint_color = vec4(1.);
uniform vec4 mountains_color : hint_color = vec4(0.);
uniform vec4 terrain_color : hint_color = vec4(1.);
uniform vec4 water_color : hint_color = vec4(0., 0., 0.4, 1.);

 
void fragment() 
{
	vec4 height = texture(TEXTURE, UV);
	vec4 terrain = texture(terrain_texture, UV);
	
	vec4 noise = texture(noise_texture, UV);
	noise.a *= 2.0;
	
	vec4 color = vec4(0);
	
	if (height.r > sea_level) 
	{
		//color = terrain_color;
		
//		if (terrain.r > coast_thickness)
//		{
//			color = coast_color;
//		}
		
	}
	else 
	{
		if (height.r > sea_level - coastline_thickness)
		{
			color = coastline_color;
		}
		else
		{
			color = water_color;
		}
	}
	
	if (terrain.r > coast_thickness)
	{
		color = terrain_color;
	}
	
	COLOR = mix(color, noise, 0.1);
}
