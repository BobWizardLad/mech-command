extends Node2D

@onready var ALLIES: Node = $Allies
@onready var ENEMIES: Node = $Enemies

var bullet_collision: Callable = _bullet_collision

# Called when the node enters the scene tree for the first time.
func _ready():
	for each in ALLIES.get_children():
		each.add_to_group("Allies", true)
	for each in ENEMIES.get_children():
		each.add_to_group("Enemies", true)
	
	print("Allies")
	print(get_tree().get_nodes_in_group("Allies"))
	print("Enemies")
	print(get_tree().get_nodes_in_group("Enemies"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _bullet_collision(body: Node2D, group: String) -> void:
	if body.find_child("Health") != null && body.is_in_group(group):
		body.find_child("Health").take_damage(30)
	else:
		pass
