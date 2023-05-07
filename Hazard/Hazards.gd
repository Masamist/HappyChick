extends Area2D

func _on_SpikeTop_body_entered(body): # The chick collide any hazard, call hurt function in "Gamestate"
	get_tree().call_group("Gamestate", "hurt")
