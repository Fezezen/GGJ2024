extends Node

@export var Weapons : Array[Resource] = []

@onready var spawnTimer : float = 1

func _process(delta):
	if spawnTimer > 0:
		spawnTimer -= delta
	else:
		spawnWeapon()

func spawnWeapon():
	spawnTimer = randf_range(5.0,8.0)
	
	var x = randf_range(10.0,get_viewport().size.x-10.0)
	
	var weap = Weapons[randi() % Weapons.size()].instantiate()
	weap.position = Vector2(x,-20)
	add_child(weap)
