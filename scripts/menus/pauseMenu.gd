class_name PauseMenu extends Control

@export var bttnReturn: Button
@export var bttnOptions: Button
@export var bttnQuitMenu: Button
@export var bttnQuitGame: Button

var open: bool = false

func _ready() -> void:
	bttnReturn.pressed.connect(_onButtonReturnPressed)
	bttnOptions.pressed.connect(_onButtonOptionsPressed)
	bttnQuitMenu.pressed.connect(_onButtonQuitMenuPressed)
	bttnQuitGame.pressed.connect(_onButtonQuitGamePressed)
	
	toggle()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		open = not open
		toggle()
	
func _onButtonReturnPressed() -> void:
	open = false
	toggle()

func _onButtonOptionsPressed() -> void:
	pass

func _onButtonQuitMenuPressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/mainMenu.tscn")

func _onButtonQuitGamePressed() -> void:
	get_tree().quit()

func toggle() -> void:
	if open:
		Global.pause = Global.PauseType.PAUSED
		show()
	else:
		Global.pause = Global.PauseType.RUNNING
		hide()
