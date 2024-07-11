extends Area2D
class_name Chainbullet

@export var proj_speed: float = 30
@export var target: Vector2 = Vector2(700, 700)
@export var origin_spread: Vector2i = Vector2i(11, -5) # Spread is max-1, min
@export var bullet_timeout: int = 2

var ignore_parent: Node
var velocity: Vector2
var life_timer: SceneTreeTimer
var origin_pos: Vector2 # Relative launch position

signal target_body_entered

func _ready() -> void:
	# Connect to the game scene to signal a bullet collision
	target_body_entered.connect(Callable(get_parent(), "_bullet_collision"))
	
	position += Vector2(randi() % origin_spread.x + origin_spread.y, randi() % origin_spread.x - origin_spread.y)
	origin_pos = position
	velocity = position.direction_to(target) * proj_speed
	look_at(target)
	rotate(PI/2) # Getting this to look forward =^)
	life_timer = get_tree().create_timer(bullet_timeout)
	life_timer.connect('timeout', life_timeout)

func _physics_process(_delta) -> void:
	position += velocity
	
	if has_overlapping_bodies():
		var body = get_overlapping_bodies()[0]
		target_body_entered.emit(body, ignore_parent)
		if body != ignore_parent:
			life_timeout()

func bullet_target(new_target: Vector2 = target) -> Area2D:
	target = new_target
	origin_pos = position
	return self

func life_timeout() -> void:
	queue_free()

# Set which node to not deal damage to; prevents self damage from
# bullets spawning inside hitbox
func set_ignore_parent(parent: Node2D) -> Area2D:
	ignore_parent = parent
	return self
