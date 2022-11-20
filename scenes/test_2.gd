extends TextureRect

export var terrain : Texture
export var terrain_color : Color = Color8(255, 247, 0)
export(String, FILE, "*.png") var path


export var action : String = "take_screenshot"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed(action):
		foo()
		print(1)

func foo():
	var image = terrain.get_data()
	image.lock()
	
	for x in image.get_width():
		for y in image.get_height():
			if image.get_pixel(x, y) != terrain_color:
				image.set_pixel(x, y, Color.black)
	
	image.save_png(path)
