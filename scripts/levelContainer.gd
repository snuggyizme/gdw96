class_name LevelContainer extends Node2D

@export var finishMenu: FinishMenu
@export var ui: UI
@export var player: PlayerCharacter

var currentMap: Node2D

var testMap = load("res://scenes/_test/testMap.tscn")
var mapWorkTest = load("res://scenes/_test/mapWorkTest.tscn")

func _ready() -> void:
	if Global.targetMapTransfer == null:
		loadMap(mapWorkTest)
	else:
		loadMap(Global.targetMapTransfer)
	resetPlayer()
	
	Global.targetMapTransfer = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		resetPlayer()

func _onFinishMenuRestartButtonPressed() -> void:
	resetPlayer()

func getMagnets() -> Array:
	if not is_instance_valid(currentMap):
		return [null]
	
	var export: Array = []
	
	for i in currentMap.get_node("Magnets").get_children():
		export.append(i.get_node("MagneticBody"))
	
	return export
	
func loadMap(mapScene: PackedScene) -> void:
	Global.pause = Global.PauseType.PAUSED_START_LVL
	
	var map = mapScene.instantiate()
	add_child(map)
	
	if currentMap != null:
		currentMap.queue_free()
		currentMap.get_node("FinishRect/Finish").body_entered.disconnect(finishLevel)
	
	currentMap = map
	
	currentMap.get_node("FinishRect/Finish").body_entered.connect(finishLevel)

func resetPlayer() -> void:
	player.global_position = currentMap.get_node("PlayerSpawn").global_position
	player.restart()
	ui.restart()
	currentMap.get_node("FinishRect").restart()
	Global.pause = Global.PauseType.PAUSED_START_LVL

func finishLevel(body: Node) -> void:
	if not body.is_in_group("Player"):
		return
	
	Global.pause = Global.PauseType.PAUSED
	
	finishMenu.finish(currentMap.get_meta("nextMap"))
