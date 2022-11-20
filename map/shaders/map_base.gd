extends TextureRect
class_name Map

export(float) var coast_thickness := MAX_COAST_THICKNESS setget set_coast_thickness, get_coast_thickness

const MIN_COAST_THICKNESS = 0.001
const MAX_COAST_THICKNESS = 0.0062


#func _on_Camera2D_zoom_changed(value : float) -> void:
#	value /= 1100.0
#	self.coast_thickness = value


func set_coast_thickness(value : float) -> void:
	value = clamp(value, MIN_COAST_THICKNESS, MAX_COAST_THICKNESS)
	
	coast_thickness = value
	material.set_shader_param("coast_thickness", coast_thickness)


func get_coast_thickness() -> float:
	coast_thickness = material.get_shader_param("coast_thickness")
	return coast_thickness
