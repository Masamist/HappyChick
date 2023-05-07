extends Node

onready var current_scene = $TitlePage
onready var current_level = "Level1"


func _ready():
	current_scene.connect("scene_changed", self, "handle_scene_changed")
	

func handle_scene_changed(current_scene_name: String):
	var next_scene
	var next_scene_name: String
	
	match current_scene_name:
		"TitlePage":
			next_scene_name = "Instruction_level1"
		"Instruction_level1":
			next_scene_name = "Level1"
		"Level1":
			next_scene_name = "LevelClear"
		"LevelClear":
			next_scene_name = "Instruction_level2"
		"Instruction_level2":
			next_scene_name = "Level2"
			current_level = "Level2"
		"Level2":
			next_scene_name = "LevelClear"
		"EndGame":
			next_scene_name = "GameOver"
		"GameOver":
			next_scene_name = current_level
		_:
			return
	
	next_scene = load("res://Levels/" + next_scene_name + ".tscn").instance()
	add_child(next_scene)
	next_scene.connect("scene_changed", self, "handle_scene_changed")
	current_scene.queue_free()
	current_scene = next_scene
	
