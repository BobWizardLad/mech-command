extends Node2D
class_name Gun

@onready var COOLDOWN: Timer = $Cooldown
@onready var RELOAD: Timer = $Reload

@export var projectile: Resource
@export var firing_cooldown: float
@export var target: Vector2 = Vector2.ZERO
@export var mag_size: int
@export var reload_time: float

var mag_count: int
var next_bullet: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	COOLDOWN.wait_time = firing_cooldown
	RELOAD.wait_time = reload_time
	mag_count = mag_size

func fire() -> void:
	if COOLDOWN.is_stopped() and mag_count > 0:
		next_bullet = projectile.instantiate()
		next_bullet.bullet_target(target).set_team(get_parent().get_groups()[-1])
		next_bullet.position = global_position
		get_parent().get_parent().add_child(next_bullet)
		mag_count -= 1
		COOLDOWN.start()
	elif mag_count <= 0 and RELOAD.is_stopped():
		RELOAD.start()

func set_target(target_pos: Vector2) -> Gun:
	target = target_pos
	return self

func load_mag():
	mag_count = mag_size
