class_name LevelMenu extends Control

@export var levels: Array[PackedScene]
@export var levelButtons: Array[Button]
@export var returnButton: Button

func _ready() -> void:
	for i in range(len(levelButtons)):
		levelButtons[i].pressed.connect(_onAnyLevelButtonPressed.bind(i))
	
	returnButton.pressed.connect(_onReturnButtonPressed)

func _onAnyLevelButtonPressed(i: int) -> void:
	changeToLevel(levels[i])

func _onReturnButtonPressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/mainMenu.tscn")

func changeToLevel(level: PackedScene):
	Global.targetMapTransfer = level
	get_tree().change_scene_to_file("res://scenes/game.tscn")
