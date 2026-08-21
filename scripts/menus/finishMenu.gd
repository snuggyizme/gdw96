class_name FinishMenu extends Control

signal restart

var next: PackedScene

func _ready() -> void:
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		hide()

func _onNextLevelButtonPressed() -> void:
	hide()
	
	Global.targetMapTransfer = next
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _onReplayButtonPressed() -> void:
	hide()
	
	restart.emit()

func finish(nextMap) -> void:
	show()
	next = nextMap
