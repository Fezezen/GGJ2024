extends Area2D

var speed = 100
var direction = 1
var ignoreBody = null

func _physics_process(delta):
	position += transform.x * speed * delta * direction

func _on_body_entered(body):
	if (body.get_instance_id() == ignoreBody.get_instance_id()):
		return
	queue_free()
	
func _set_direction(dir):
	direction = dir

func _set_speed(spd):
	speed = spd

func _set_ignoreBody(body):
	ignoreBody = body
