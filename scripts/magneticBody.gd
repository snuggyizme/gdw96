@icon("res://assets/sprites/_test/hi.png")
class_name MagneticBody extends Node2D

enum Polarity { POSITIVE, NEGATIVE }

@export var polarity: Polarity = Polarity.POSITIVE
@export var strength: float = 7000.0
@export var effectiveRange: float = 70.0
@export var size: int = 64 ## Size of the ball
