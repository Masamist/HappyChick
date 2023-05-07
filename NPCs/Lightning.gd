extends Node2D

const SPEED = 450 # Speed for the lightning falling down

func _ready():
	set_as_toplevel(true)
	global_position = get_parent().global_position


func _process(delta):
	position.y += SPEED * delta # the lightning going down with setup speed
	manage_collision()


func manage_collision(): # Function for when lighting collide something
	var collider = $Area2D.get_overlapping_bodies() # the things colliding (the chick and ground)
	for object in collider: # conditional check whatever in the collider
		if object.name == "Player": # if the collider is the player
			get_tree().call_group("Gamestate", "hurt") # the player hurt and loose a life
		queue_free() # Whatever the lighting hits collider, it will disappear
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # the lightning off the screen then it disappear


