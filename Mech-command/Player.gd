extends CharacterBody2D

const SPEED: float = 300.0

func _physics_process(delta) -> void:
	# Get the input direction in both axis and handle direction
	var horizontal = Input.get_axis("player_left", "player_right")
	var vertical = Input.get_axis("player_up", "player_down")
	var direction = Vector2(horizontal, vertical).normalized()
	
	# Execute tween of velocity in direction by SPEED
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'velocity', direction * SPEED, 0.13).set_trans(Tween.TRANS_SINE)

	move_and_slide()
