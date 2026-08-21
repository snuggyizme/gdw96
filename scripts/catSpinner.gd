class_name SpinningCat extends MeshInstance3D

@export var speed := 1.0

func _physics_process(delta: float) -> void:
	rotate(Vector3.ONE, speed * delta)
	
	rotate_x(speed * delta)
