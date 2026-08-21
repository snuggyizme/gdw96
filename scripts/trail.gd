class_name Trail extends Line2D

@export var maxPoints := 40
@export var driftSpeed := 0.0

@onready var parent = get_parent()

func _ready() -> void:
	position = Vector2.ZERO
	
	antialiased = true
	joint_mode = Line2D.LINE_JOINT_ROUND
	begin_cap_mode = Line2D.LINE_CAP_ROUND
	end_cap_mode = Line2D.LINE_CAP_ROUND
	top_level = true
	
	var grad := Gradient.new()
	grad.set_color(0, default_color)
	grad.set_color(1, Color(
		default_color.r,
		default_color.g,
		default_color.b,
		0
	))
	gradient = grad
	
	var curve := Curve.new()
	curve.add_point(Vector2(0.0, 0.0))
	curve.add_point(Vector2(1.0, 1.0))
	width_curve = curve

func _physics_process(_delta):
	add_point(parent.global_position)
	if points.size() > maxPoints:
		remove_point(0)
	
	var pointsCopy := get_points()
	for point in pointsCopy:
		var index = pointsCopy.find(point)
		point.y -= driftSpeed
		pointsCopy[index] = point
		
		set_points(pointsCopy)
