extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -450.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var lastDirection = 1

@export var controls: Resource = null
@export var Bullet : PackedScene

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

func shoot(dir):
	var b = Bullet.instantiate()
	add_child(b)
	b._set_direction(dir)
	if dir >= 0:
		b.transform = $Bullet_Right.transform
	else:
		b.transform = $Bullet_Left.transform
