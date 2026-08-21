class_name OptionsMenu extends Control

func _onFullscreenButtonPressed() -> void:
	print(DisplayServer.window_get_mode())
	
	match DisplayServer.window_get_mode():
		DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		DisplayServer.WINDOW_MODE_WINDOWED | DisplayServer.WINDOW_MODE_MAXIMIZED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _onVolumeSliderDragReleased(value_changed: bool) -> void:
	if not value_changed:
		return
	
	Global.volume = %VolumeSlider.value
