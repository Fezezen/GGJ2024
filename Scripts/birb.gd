extends AnimatedSprite2D

@onready var path: PathFollow2D = $"../BirdPath2D/PathFollow2D"
@onready var attackTimer: Timer = $Timer
@export var speed: float = 50
@export var projectile: PackedScene

func _ready():
	play("default")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	path.progress_ratio += delta * speed
	position = path.position
	
	if attackTimer.time_left <= 0:
		var p = projectile.instantiate()
		p.position = position
		get_tree().get_root().add_child(p)
		attackTimer.start()
