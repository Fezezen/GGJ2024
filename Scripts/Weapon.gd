extends RigidBody2D

@export var Projectile : PackedScene
@export var shootCooldown : float = 0.3

func _integrate_forces(state):
	rotation_degrees = 0

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body._set_weapon(Projectile, shootCooldown)
		queue_free()
