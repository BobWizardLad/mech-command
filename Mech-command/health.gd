extends Node2D
class_name Health

@export var HEALTH_MAX: float

@onready var HEALTH_BAR: TextureProgressBar = $HealthBar

var current_health: float

func _ready():
	current_health = HEALTH_MAX
	HEALTH_BAR.max_value = HEALTH_MAX

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	HEALTH_BAR.value = current_health

	if current_health <= 0:
		get_parent().queue_free()

func take_damage(damage: float) -> float:
	current_health -= damage
	return current_health
