extends Area2D

var speed = 1000
var velocity = Vector2(1,0)
var ignoreBody = null

func _physics_process(delta):
	velocity.y += gravity * delta
	position += velocity * delta

func _on_body_entered(body):
	if (body.get_instance_id() == ignoreBody.get_instance_id()):
		return
	queue_free()
	
func _set_velocity(dir : Vector2):
	velocity = dir * speed

func _set_speed(spd):
	speed = spd

func _set_ignoreBody(body):
	ignoreBody = body
