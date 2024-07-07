extends CharacterBody2D
class_name Flare

@onready var Sprite: Sprite2D = $Sprite

@export var rot_speed: float = 5
@export var proj_speed: float = 400

var height: float = 1 # The projectile 'height': scalar for object scale
var flare_target: Vector2 = position # Flare landing position
var origin_pos: Vector2 = position # Relative launch position
var flare_travel: bool = false # Is the projectile moving?
var travel_arc_timing # Calculated travel time between launch and landing

func _physics_process(delta) -> void:
	velocity = position.direction_to(flare_target).normalized() * proj_speed
	
	# Flare motion in the x/y plane; seperate from the 'height' traversal
	if origin_pos < flare_target and not position >= flare_target:
		move_and_slide()
	elif origin_pos > flare_target and not position <= flare_target:
		move_and_slide()
	# Constant calculation of the scale relative to the proj 'height'
	scale = Vector2.ONE * height
	
	# Flare rotates as it travels
	var tween = get_tree().create_tween()
	tween.tween_property(Sprite, 'rotation', Sprite.rotation + rot_speed, 0.3).set_trans(Tween.TRANS_CIRC)
	
	# Activate flare travel time
	if flare_travel:
		flare_ascent(travel_arc_timing)
		flare_travel = false

# Set the flare arc varaibles relative to parameters
# target is the target landing spot of the flare
func set_flare_travel(target: Vector2) -> Node:
	flare_travel = true
	flare_target = target
	origin_pos = position
	travel_arc_timing = flare_target.distance_to(self.position)/proj_speed
	return self

# Utility Function: Calls the tween for the second half of the flare arc
# Defaults to the node's built in arc; can be overwritten
func flare_descent(arc: float = travel_arc_timing) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'height', 1, (arc)/2).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(landed)

# Utility Funtion: Calls the tween for the first half of the flare arc
# Defaults to the node's built in arc; can be overwritten
func flare_ascent(arc: float = travel_arc_timing) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'height', 3, (arc)/2).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(flare_descent)
	
func landed():
	var allies = get_tree().get_nodes_in_group("Allies")
	for each in allies:
		each.path_to_command(flare_target)
	queue_free()
