extends RigidBody2D

@export var Projectile : PackedScene

func _integrate_forces(state):
	rotation_degrees = 0

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body._set_weapon(Projectile)
		queue_free()
