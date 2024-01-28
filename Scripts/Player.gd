extends CharacterBody2D

@export var SPEED = 500.0
@export var JUMP_VELOCITY = -480.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var lastDirection = 1
var spawnProtection = 0
var spawnProtectionFlash = 0

@onready var screen_size = get_viewport().size

@export var controls: Resource = null
@export var Bullet : PackedScene

var shootCooldown: float = 0.3
var currentShootCooldown: float = 0

@export var health : int = 100
@onready var maxHealth : int = health
@onready var startPosition = position

@export var weaponIndex : int = 0

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
	# check shoot cooldown
	if currentShootCooldown > 0 or health <= 0:
		return
		
	currentShootCooldown = shootCooldown
	
	var b = Bullet.instantiate()
	get_tree().get_root().add_child(b)
	b._set_dir(Vector2(dir,-.2))
	b._set_velocity(b._get_velocity() + get_real_velocity())
	b._set_ignoreBody(self)
	if dir >= 0:
		b.global_transform = $Bullet_Right.global_transform
	else:
		b.global_transform = $Bullet_Left.global_transform

func _process(delta):
	if currentShootCooldown > 0:
		currentShootCooldown -= delta
	
	# spawn protection logic and flashing
	if spawnProtection > 0:
		spawnProtection -= delta
		spawnProtectionFlash += delta
		
		if spawnProtection <= 0:
			modulate.a = 1
		else:
			if spawnProtectionFlash > 0.5:
				spawnProtectionFlash = 0
			
			if spawnProtectionFlash > 0.25:
				modulate.a = 0.5
			else:
				modulate.a = 1

func screen_wrap():
	position = position.posmodv(screen_size)
	
func _take_damage(damage):
	if health <= 0 or spawnProtection > 0:
		return
	health -= damage
	
	if health <= 0:
		respawn()

func respawn():
	hide()
	set_process_input(false)
	await get_tree().create_timer(1.0).timeout
	show()
	set_process_input(true)
	health = maxHealth
	position = startPosition
	spawnProtection = 2

func _set_weapon(weapon : PackedScene, coolDown):
	Bullet = weapon
	shootCooldown = coolDown
