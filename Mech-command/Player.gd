extends CharacterBody2D

const SPEED: float = 300.0

@onready var MINIGUN: Gun = $Minigun
@onready var FLARE: Resource = load("res://flare.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("flare"):
		var new_flare: Flare = FLARE.instantiate()
		new_flare.position = position
		new_flare.set_flare_travel(get_global_mouse_position())
		get_parent().add_child(new_flare)
	
	if Input.is_action_pressed("minigun"):
		MINIGUN.set_target(get_global_mouse_position()).set_firing(true)
	else:
		MINIGUN.set_firing(false)

func _physics_process(delta) -> void:
	# Get the input direction in both axis and handle direction
	var horizontal = Input.get_axis("player_left", "player_right")
	var vertical = Input.get_axis("player_up", "player_down")
	var direction = Vector2(horizontal, vertical).normalized()
	
	# Execute tween of velocity in direction by SPEED
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'velocity', direction * SPEED, 0.13).set_trans(Tween.TRANS_SINE)

	move_and_slide()
