extends ColorRect

func _onBodyEnteredFinish(body: Node2D) -> void:
	if body.is_in_group("Player"):
		material.set_shader_parameter("aOrB", true)

func restart() -> void:
	material.set_shader_parameter("aOrB", false)
