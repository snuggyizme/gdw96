class_name SpinningCat extends MeshInstance3D

@export var speed := Vector3.ONE

func _physics_process(delta: float) -> void:	
	rotate_x(speed.x * delta)
	rotate_y(speed.y * delta)
	rotate_z(speed.z * delta)
