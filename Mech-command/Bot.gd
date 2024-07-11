extends CharacterBody2D
class_name Bot

@export var SPEED: float = 200.0

@onready var HEALTH: Health = $Health

var nav_target: Vector2

func _physics_process(delta):
	pass #move_and_slide()
