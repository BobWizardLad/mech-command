extends Node2D

@onready var ALLIES: Node = $Allies
@onready var ENEMIES: Node = $Enemies

# Called when the node enters the scene tree for the first time.
func _ready():
	for each in ALLIES.get_children():
		each.add_to_group("Allies")
	for each in ENEMIES.get_children():
		each.add_to_group("Enemies")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
