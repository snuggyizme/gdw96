class_name UI extends CanvasLayer

var time: float = 0.0

func _process(delta: float) -> void:
	time += delta
	
	@warning_ignore("integer_division")
	var mins: int = int(time) / 60
	var secs: int = int(time) % 60
	var msecs: int = int((time - floor(time)) * 100)
	
	var sMins = str(mins).pad_zeros(2)
	var sSecs = str(secs).pad_zeros(2)
	var sMsecs = str(msecs).pad_zeros(2)
	
	$Timer.text = sMins + ":" + sSecs + ":" + sMsecs

func restart() -> void:
	time = 0.0
