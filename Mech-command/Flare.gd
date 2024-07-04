extends CharacterBody2D

@onready var Sprite: Sprite2D = $Sprite

@export var rot_speed: float = 5
@export var proj_speed: float = 400

var height: float = 1
var flare_target: Vector2 = position
var origin_pos: Vector2 = position
var flare_travel: bool = false
var travel_arc_timing

func _ready():
	pass

func _physics_process(delta) -> void:
	# TEST input to fire flare
	if Input.is_action_just_pressed("flare"):
		flare_target = get_global_mouse_position()
		origin_pos = position
		set_flare_travel(flare_target)
		
		var dir = position.direction_to(flare_target)
		velocity = dir.normalized() * proj_speed
	
	if origin_pos < flare_target and not position >= flare_target:
		move_and_slide()
	elif origin_pos > flare_target and not position <= flare_target:
		move_and_slide()
	
	# Flare rotates as it travels
	var tween = get_tree().create_tween()
	tween.tween_property(Sprite, 'rotation', Sprite.rotation + rot_speed, 0.3).set_trans(Tween.TRANS_CIRC)
	
	scale = Vector2.ONE * height
	
	if flare_travel:
		flare_ascent()
		flare_travel = false

func set_flare_travel(target: Vector2) -> Node:
	flare_travel = true
	flare_target = target
	travel_arc_timing = flare_target.distance_to(self.position)/proj_speed
	return self

func flare_descent() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'height', 1, (travel_arc_timing)/2).set_trans(Tween.TRANS_SINE)

func flare_ascent() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'height', 3, (travel_arc_timing)/2).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(flare_descent)
