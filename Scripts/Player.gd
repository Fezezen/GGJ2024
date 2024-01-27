extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -450.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var lastDirection = 1

@onready var screen_size = get_viewport().size

@export var controls: Resource = null
@export var Bullet : PackedScene

@export var health : int = 100

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed(controls.jump) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis(controls.move_left, controls.move_right)
	if direction:
		lastDirection = direction
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Handle shooting
	if Input.is_action_just_pressed(controls.shoot):
		shoot(lastDirection)

	move_and_slide()
	screen_wrap()

func shoot(dir):
	var b = Bullet.instantiate()
	get_tree().get_root().add_child(b)
	b._set_dir(Vector2(dir,-.2))
	b._set_velocity(b._get_velocity() + get_real_velocity())
	b._set_ignoreBody(self)
	if dir >= 0:
		b.global_transform = $Bullet_Right.global_transform
	else:
		b.global_transform = $Bullet_Left.global_transform

func screen_wrap():
	position = position.posmodv(screen_size)
	
func _take_damage(damage):
	health -= damage
	
	if health <= 0:
		queue_free()
