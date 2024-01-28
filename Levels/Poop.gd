extends Area2D

@onready var timer: Timer = $Timer
@export var speed: float = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += speed * delta
	
	if timer.time_left <= 0:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body._take_damage(50)
		queue_free()
