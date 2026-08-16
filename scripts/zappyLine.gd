@icon("res://assets/sprites/_test/hi.png")
class_name ZappyLine extends Line2D

var fromNode: Node2D
var targetPos: Vector2

func _ready() -> void:
	top_level = true

func _process(_delta: float) -> void:
	if not is_instance_valid(fromNode):
		queue_free()
		return
	
	if fromNode.global_position.distance_to(targetPos) > 400:
		queue_free()
		return
	
	points = PackedVector2Array([fromNode.global_position, targetPos])

func start(f: Node2D, t: Vector2, l: float) -> void:
	fromNode = f
	targetPos = t
	await get_tree().create_timer(l).timeout
	
	if Input.is_action_pressed("shift"):
		f.makeLine(randf_range(0.3, 1.1))
	queue_free()
