extends Node2D
class_name Gun

@onready var COOLDOWN: Timer = $Cooldown
@onready var RELOAD: Timer = $Reload

@export var projectile: Resource
@export var firing_cooldown: float
@export var target: Vector2 = Vector2.ZERO
@export var mag_size: int
@export var reload_time: float

var firing: bool = false
var mag_count: int
var next_bullet: Chainbullet

# Called when the node enters the scene tree for the first time.
func _ready():
	COOLDOWN.wait_time = firing_cooldown
	RELOAD.wait_time = reload_time
	mag_count = mag_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if firing and COOLDOWN.is_stopped() and mag_count > 0:
		next_bullet = projectile.instantiate()
		next_bullet.bullet_target(target)
		next_bullet.position = global_position
		get_parent().get_parent().add_child(next_bullet)
		mag_count -= 1
		COOLDOWN.start()
	elif firing and mag_count <= 0:
		RELOAD.start()

func set_firing(is_firing: bool) -> Gun:
	firing = is_firing
	return self

func set_target(target_pos: Vector2) -> Gun:
	target = target_pos
	return self

func load_mag():
	mag_count = mag_size
