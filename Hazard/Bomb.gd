extends Node2D

onready var timer = get_node("Timer")
var taken = false
var light = false

func _ready():
	$ShockWave.monitoring = false
	pass

func _on_Area2D_body_entered(body):
	if not taken:
		taken = true
		$Area2D/AnimationPlayer.play("Bomb")
		$AudioStreamPlayer.play()
		timer.start()
		
func _on_Timer_timeout():
	$Particles2D.emitting = true
	$Particles2D/Particles2D2.emitting = true
	$Particles2D/Particles2D.emitting = true
	$Particles2D/Particles2D3.emitting = true
	$ShockWave.monitoring = true

func _on_ShockWave_body_entered(body):
	if not light:
		light = true
		get_tree().call_group("Gamestate", "hurt")
	

func die():
	queue_free()








