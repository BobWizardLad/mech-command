extends CharacterBody2D
class_name Bot

@export var SPEED: float = 200.0

@onready var NAV_AGENT: NavigationAgent2D = $NavAgent
@onready var HEALTH: Health = $Health

var nav_target: Vector2

func _physics_process(delta):
	NAV_AGENT.get_next_path_position()
	velocity = NAV_AGENT.velocity.normalized() * SPEED
	move_and_slide()

func path_to_command(target: Vector2) -> CharacterBody2D:
	NAV_AGENT.target_position = target
	return self

func on_been_attacked():
	print("OW")
	pass
