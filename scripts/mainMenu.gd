class_name MainMenu extends Control

@export var playButton: Button
@export var exitButton: Button

func _ready() -> void:
	playButton.pressed.connect(_onPlayPressed)
	exitButton.pressed.connect(_onExitPressed)

func _onPlayPressed() -> void:
	pass

func _onExitPressed() -> void:
	get_tree().quit()
