extends Node2D

var taken = false

func _on_collectableItem_body_entered(body):
	if not taken:
		taken = true
		$AnimationPlayer.play("die")
		$AudioStreamPlayer.play()
		get_tree().call_group("Gamestate", "collectableItem_up")
#
#
func die():
	queue_free()
