extends Node2D

@export var nextLevelName = ""

@export var Player1 : Node
@export var Player2 : Node

@onready var p1Lives = 3
@onready var p2Lives = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	Player1.connect("on_death", p1_loseLife)
	Player2.connect("on_death", p2_loseLife)

func p1_loseLife() -> void:
	p1Lives -= 1
	checkWin()
	
func p2_loseLife() -> void:
	p2Lives -= 1
	checkWin()

func checkWin():
	if p1Lives <= 0 or p2Lives <= 0:
		get_tree().change_scene_to_file("res://Levels/" + nextLevelName + ".tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Next_Level"):
		get_tree().change_scene_to_file("res://Levels/" + nextLevelName + ".tscn")
