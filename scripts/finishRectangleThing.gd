@tool
class_name FinishCollider extends CollisionShape2D

func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		return
	
	if shape:
		shape = shape.duplicate()
	
	var colourRect = get_parent().get_parent() 
	if colourRect is not ColorRect:
		return
	
	var trueSize: Vector2 = colourRect.size * colourRect.scale
	
	var rectangle: RectangleShape2D = shape
	
	rectangle.size = trueSize
	
	global_position = colourRect.global_position + (colourRect.size / 2)
	
	colourRect.get_node("ColorRect").size = trueSize
