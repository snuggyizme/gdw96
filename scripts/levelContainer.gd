class_name LevelContainer extends Node2D

@export var currentMap: Node2D

func _ready() -> void:
	resetPlayer()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart") and Global.pause == false:
		resetPlayer()

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
	
	currentMap.queue_free()
	currentMap.get_node("Finish").body_entered.disconnect(finishLevel)
	
	currentMap = map
	
	currentMap.get_node("Finish").body_entered.connect(finishLevel)

func resetPlayer() -> void:
	$"../PlayerCharacter".global_position = currentMap.get_node("PlayerSpawn").global_position
	$"../PlayerCharacter".restart()
	$"../UI".restart()

func finishLevel(body: Node) -> void:
	if not body.is_in_group("Player"):
		return
	
	Global.pause = true
	print("finished!", $"../UI".time)
