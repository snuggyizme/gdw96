class_name LevelContainer extends Node2D

@export var currentMap: Node2D

func getMagnets() -> Array:
	if not is_instance_valid(currentMap):
		return [null]
	
	var export: Array = []
	
	for i in currentMap.get_node("Magnets").get_children():
		export.append(i.get_node("MagneticBody"))
	
	return export
	
func loadMap(mapScene: PackedScene) -> void:
	var map = mapScene.instantiate()
	add_child(map)
	currentMap = map

func resetPlayer() -> void:
	$"../PlayerCharacter".global_position = currentMap.get_node("playerSpawn").global_position
	$"../PlayerCharacter".restart()
	$"../UI".restart()
