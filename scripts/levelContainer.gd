class_name LevelContainer extends Node2D

@export var level: Node2D

func getMagnets() -> Array:
	if not is_instance_valid(level):
		return [null]
	
	var export: Array = []
	
	for i in level.get_node("Magnets").get_children():
		export.append(i.get_node("MagneticBody"))
	
	return export
	
	
