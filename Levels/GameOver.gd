extends Control

signal scene_changed(scene_name)

export (String) var scene_name = "scene"

func _on_RestartButton_pressed():
	emit_signal("scene_changed", scene_name)

#	get_tree().change_scene("res://Levels/Level1.tscn""")

