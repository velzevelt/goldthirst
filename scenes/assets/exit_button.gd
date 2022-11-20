extends Button


func _ready() -> void:
# warning-ignore:return_value_discarded
	self.connect("button_up", self, "_on_button_up")


func _on_button_up() -> void:
	get_tree().quit()
