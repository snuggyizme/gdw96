class_name HoverEffectManager extends Control

@export var area: Node

var mouseIn: bool = false

func _ready() -> void:
	pivot_offset = size / 2.0
	area.mouse_entered.connect(_onTitleMouseEntered)
	area.mouse_exited.connect(_onTitleMouseExited)

func _onTitleMouseEntered() -> void:
	mouseIn = true

func _onTitleMouseExited() -> void:
	mouseIn = false

func _process(_delta: float) -> void:
	var targetScale = Vector2.ONE * 1.2 if mouseIn else Vector2.ONE
	scale = scale.lerp(targetScale, 0.5)
