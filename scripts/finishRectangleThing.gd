@tool
class_name FinishCollider extends CollisionShape2D

@export var bypass: bool

func _process(_delta: float) -> void:
	if not Engine.is_editor_hint() and not bypass:
		return

	var colourRect := get_parent().get_parent() as ColorRect
	if not colourRect:
		return

	var rectangle := shape as RectangleShape2D
	if not rectangle:
		return

	rectangle.size = colourRect.size
	position = colourRect.size / 2.0

	var visualRect := get_node("../../ColorRect") as ColorRect
	visualRect.position = Vector2.ZERO
	visualRect.size = colourRect.size
