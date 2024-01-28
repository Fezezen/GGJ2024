extends StaticBody2D

@export var xSpeed: float = 100
@export var ySpeed: float = 0
var playerBody: CharacterBody2D

var deltaTime = 0

var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = $Timer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	deltaTime = delta
	
	position.x += xSpeed * delta
	position.y += ySpeed * delta
	
	if timer.time_left <= 0:
		queue_free()
		
	#if playerBody != null:
		#playerBody.position.x += xSpeed * delta

func _on_area_2d_body_entered(body : CharacterBody2D):
	if body.is_in_group("Player"):
		playerBody = body
	else:
		playerBody = null
