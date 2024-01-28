extends CanvasLayer

@export var levelLoader: LevelLoader

@onready var lives1: Label
@onready var lives2: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	lives1 = $Lives1
	lives2 = $Lives2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lives1.text = str(levelLoader.p1Lives)
	lives2.text = str(levelLoader.p2Lives)
	pass
