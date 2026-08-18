extends ColorRect

func _onBodyEnteredFinish(body: Node2D) -> void:
	if body.is_in_group("Player"):
		material.set_shader_parameter("aOrB", true)
	
	var tween = get_tree().create_tween()
	tween.tween_method(
		func(x: float):
			material.set_shader_parameter("speed", x),
		0.1, 0.5, 0.3
	)

func restart() -> void:
	material.set_shader_parameter("aOrB", false)
	
	var tween = get_tree().create_tween()
	tween.tween_method(
		func(x: float):
			material.set_shader_parameter("speed", x),
		material.get_shader_parameter("speed"), 0.1, 0.3
	)
