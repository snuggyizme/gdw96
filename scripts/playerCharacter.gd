class_name PlayerCharacter extends CharacterBody2D

const POS_MAT := preload("res://assets/resources/positiveMat.tres")
const NEG_MAT := preload("res://assets/resources/negativeMat.tres")

@export_group("Movement")
@export var topSpeed: float
@export var walkSpeed: float
@export var jumpSpeed: float
@export var gravity: float
@export var fallSpeedHoldThing: Gradient
@export var maxTimeWalking: float
@export var overSpeedSlowdownSpeed: float
@export var walkBackSpeed: float
@export var decelSpeed: float

@export_group("Magnets")
@export var magnetFalloffGradient: Gradient
@export_range(0.0, 1.0, 0.05) var steerMagnetStrength: float
@export var posGrad: Gradient
@export var negGrad: Gradient
@export var spaceMult: float

var lastForces := Vector2.ZERO
var closestMagnet: MagneticBody
var charge: float:
	set(x):
		if is_inside_tree():
			$ProgressBar.value = x
		charge = x
var cooldown: float = 0.0

@onready var levelContainer: LevelContainer = get_node("/root/Game/LevelContainer")

func _ready() -> void:
	bounceWarnings()

func _physics_process(delta: float) -> void:
	# Warnings
	$Warnings/Warning20.visible = ( charge < 25 )
	$Warnings/Warning50.visible = ( charge > 25 and charge < 50 )
	
	# Movement
	var dir = Input.get_vector(
		"a", "d", "w", "s"
	)
	
	if dir.x != 0.0:
		var reversing: bool = sign(velocity.x) != 0.0 and sign(velocity.x) != sign(dir.x)
		var accel: float = walkBackSpeed if reversing else walkSpeed
		
		velocity.x = move_toward(
			velocity.x, topSpeed * dir.x, accel * delta
		)
	else:
		velocity.x = move_toward(velocity.x, 0.0, decelSpeed * delta)
	
	if not Input.is_action_just_pressed("w"):
		velocity.y += gravity * delta
	elif is_on_floor():
		velocity.y -= jumpSpeed
	
	if not is_on_floor() and dir.y:
		var thingoSpeed: float = (
			fallSpeedHoldThing.sample(remap(dir.y, -1, 1, 0, 1)).r8
			- fallSpeedHoldThing.sample(remap(dir.y, -1, 1, 0, 1)).b8
		)
		velocity.y += thingoSpeed * 0.07
	
	# ! MAGNETS !
	var magnets: Array = levelContainer.getMagnets()
	var forces := Vector2.ZERO
	
	@warning_ignore("unused_variable")
	closestMagnet = null
	var closestDistance: float = INF
	
	for m in magnets:
		var difference: Vector2 = global_position - m.global_position
		var distance: float = difference.length()
		var direction: Vector2 = difference.normalized()
		
		if distance > m.effectiveRange:
			continue
		
		var strength: float = m.strength * magnetFalloffGradient.sample(
			(m.effectiveRange - distance) /  m.effectiveRange
		).r
		
		direction *= 1.0 if m.polarity == MagneticBody.Polarity.POSITIVE else -1.0
		
		var naturalForce = direction * strength * delta
		var steeredDirection = naturalForce.normalized().slerp(
			get_global_mouse_position().normalized(),
			steerMagnetStrength
		)
		
		var force = steeredDirection * naturalForce.length() 
		forces += force
		
		if distance < closestDistance:
			closestDistance = distance
			closestMagnet = m
	
	cooldown += delta
	
	var shiftPressed := Input.is_action_pressed("shift")
	var spacePressed := Input.is_action_just_pressed("space")
	
	if spacePressed and cooldown > 0.2:
		if charge >= 9.5:
			velocity += forces * spaceMult
			charge -= 9.5 
			cooldown = 0.0
	elif shiftPressed and charge >= 2.5 * delta:
		velocity += forces
		charge -= 2.5 * delta
	
	# ~move and slide~
	move_and_slide()
	
	if forces != Vector2.ZERO:
		lastForces = forces
		$Sprite2D.rotation = lastForces.normalized().angle()
	else:
		$Sprite2D.rotate(deg_to_rad(5))
	
	$Sprite2D.flip_v = cos($Sprite2D.rotation) < 0
	
	# Why did I do this, it doesn't make sense.
	#if closestMagnet:
	#	$Sprite2D.material = POS_MAT if closestMagnet.polarity == MagneticBody.Polarity.NEGATIVE else NEG_MAT

func bounceWarnings() -> void:
	var tween := create_tween()
	
	jiggleWarnings()
	
	tween.set_trans(Tween.TRANS_CIRC)
	tween.tween_property(
		$Warnings, "scale", Vector2.ONE * 3, 0.15
	)
	tween.tween_property(
		$Warnings, "scale", Vector2.ONE, 0.1
	)
	tween.tween_property(
		$Warnings, "scale", Vector2.ONE * 2, 0.15
	)
	tween.tween_property(
		$Warnings, "scale", Vector2.ONE, 0.10
	)
	tween.tween_interval(0.3)
	
	await tween.finished
	
	bounceWarnings()

func jiggleWarnings() -> void:
	# woah calm down buddy
	
	var power: float = 9
	
	var tween := create_tween()
	
	tween.tween_property($Warnings, "rotation_degrees", power, 0.0625)
	tween.tween_property($Warnings, "rotation_degrees", -power - 3, 0.0625)
	tween.tween_property($Warnings, "rotation_degrees", power, 0.0625)
	tween.tween_property($Warnings, "rotation_degrees", 0, 0.0625)

func restart() -> void:
	charge = 100.0
	
