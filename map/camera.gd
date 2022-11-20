extends Camera2D

#signal zoom_changed(value)

export(float, 1.0, 15.0, 0.1) var _sensitivity := 6.0

onready var _tween = $Tween

var _is_max_zoom := false setget set_max_zoom_flag, get_max_zoom_flag

const SPEED = 25

func _process(_delta: float) -> void:
	
	var zoom_factor = _get_zoom_factor()
	var direction = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	
	if Input.is_action_pressed("ui_down"):
		direction.y = 1
	
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
	
	position += direction.normalized() * SPEED * zoom_factor

func _input(event: InputEvent) -> void:
	
	if _tween.is_active():
		return
	
	var zoom_factor = _get_zoom_factor()
	
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				_tween.interpolate_property(self, "zoom", zoom, zoom + Vector2.ONE * zoom_factor, 0.3, 
				Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
				_tween.start()
				#yield(_tween, "tween_all_completed")
				#emit_signal("zoom_changed", zoom.x)
			
			if event.button_index == BUTTON_WHEEL_DOWN:
				if zoom.x - 1.0 * zoom_factor.x > 0.1:
					_tween.interpolate_property(self, "zoom", zoom, zoom - Vector2.ONE * zoom_factor, 0.3, 
					Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
					_tween.start()
				else:
					_tween.interpolate_property(self, "zoom", zoom, Vector2(0.3, 0.3), 0.3, 
					Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
					_tween.start()
				#yield(_tween, "tween_all_completed")
				#emit_signal("zoom_changed", zoom.x)


func _get_zoom_factor() -> Vector2:
	return Vector2(clamp(zoom.x, 0.1, _sensitivity), clamp(zoom.y, 0.1, _sensitivity))


func set_max_zoom_flag(value : bool) -> void:
	_is_max_zoom = value
	emit_signal("max_zoom_toggled", _is_max_zoom)


func get_max_zoom_flag() -> bool:
	return _is_max_zoom
