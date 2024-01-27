extends Area2D

var speed = 100
var direction = 1


func _physics_process(delta):
	position += transform.x * speed * delta * direction

func _on_Bullet_body_entered(body):
	queue_free()
	
func _set_direction(dir):
	direction = dir
