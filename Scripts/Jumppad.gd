extends Area2D

@export var jumpPower: float = -1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body : CharacterBody2D):
	if body.is_in_group("Player"):
		body.velocity.y = jumpPower
