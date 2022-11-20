extends Label

export var _prefix := "FPS: "


func _physics_process(_delta: float) -> void:
	text = _prefix + str(Engine.get_frames_per_second())
