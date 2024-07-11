extends Node2D

@onready var ALLIES: Node = $Allies
@onready var ENEMIES: Node = $Enemies

var bullet_collision: Callable = _bullet_collision

# Called when the node enters the scene tree for the first time.
func _ready():
	for each in ALLIES.get_children():
		each.add_to_group("Allies")
	for each in ENEMIES.get_children():
		each.add_to_group("Enemies")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _bullet_collision(body: Node2D, ignore: Node2D) -> void:
	if body.find_child("Health") != null && body != ignore:
		body.find_child("Health").take_damage(30)
	else:
		pass
