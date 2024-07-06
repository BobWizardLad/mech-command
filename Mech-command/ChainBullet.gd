extends CharacterBody2D
class_name Chainbullet

@export var proj_speed: float = 1000
@export var target: Vector2 = Vector2(700, 700)
@export var spread: Vector2i = Vector2i(11, -5) # Spread is max-1, min
@export var bullet_timeout: int = 2

var life_timer: SceneTreeTimer
var origin_pos: Vector2 = position # Relative launch position

func _ready() -> void:
	position += Vector2(randi() % spread.x + spread.y, randi() % spread.x - spread.y)
	look_at(target)
	velocity = position.direction_to(target).normalized() * proj_speed
	life_timer = get_tree().create_timer(bullet_timeout)
	life_timer.connect('timeout', life_timeout)

func _physics_process(delta) -> void:
	move_and_slide()

func bullet_target(new_target: Vector2 = target) -> CharacterBody2D:
	target = new_target
	origin_pos = position
	return self

func life_timeout() -> void:
	queue_free()

