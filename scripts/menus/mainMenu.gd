class_name MainMenu extends Control

@export var playButton: Button
@export var exitButton: Button

func _ready() -> void:
	playButton.pressed.connect(_onPlayPressed)
	exitButton.pressed.connect(_onExitPressed)

func _onPlayPressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/levelMenu.tscn")

func _onExitPressed() -> void:
	get_tree().quit()
