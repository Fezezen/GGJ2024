extends Area2D

@export var speed = 1000
@export var damage = 30

var velocity = Vector2(1,0)
var ignoreBody = null

func _physics_process(delta):
	velocity.y += gravity * delta
	position += velocity * delta

func _on_body_entered(body):
	if not is_instance_valid(body):
		return
	
	if (body.get_instance_id() == ignoreBody.get_instance_id() or not body.is_visible()):
		return
	
	if body.is_in_group("Player"):
		body._take_damage(damage)
		
		#play impact sound
		var sfxPlayer = $ImpactSFX.duplicate()
		sfxPlayer.finished.connect(queue_free)
		get_tree().get_root().add_child(sfxPlayer)
		sfxPlayer.play()
		
	queue_free()
	
func _set_dir(dir : Vector2):
	velocity = dir * speed

func _get_velocity():
	return velocity
	
func _set_velocity(vel):
	velocity = vel

func _set_speed(spd):
	speed = spd

func _set_ignoreBody(body):
	ignoreBody = body
