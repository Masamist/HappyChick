extends KinematicBody2D

var motion = Vector2(0, 0) # Setup motion

const SPEED = 1000 # Walking speed
const GRAVITY = 150 # Gravity
const UP = Vector2(0, -1)
const JUMP_SPEED = 2500 # Jump speed
const WORLD_LIMIT = 4000 # Game over measurement for the chick falls down from platform
const BOOST_MULTIPLAYER = 1.5 # Booster for Jump pad

signal animate

func _physics_process(delta):
	apply_gravity()
	jump()
	move()
	animate() # for the player animation
	move_and_slide(motion, UP)

func apply_gravity(): # create gravity so the chick jump!
	if position.y > WORLD_LIMIT: #The chick falls setup depth then it's  game over
		get_tree().call_group("Gamestate", "end_game") # Call the function for game over scene
	if is_on_floor() and motion.y >0: # When the chick on the floor, it stay on the platform
		motion.y = 0
	elif is_on_ceiling(): # When the chick reaches to ceiling, then it starts going down
		motion.y = 1
	else: 
		motion.y += GRAVITY # When the chick is not on the floor, it goes down with setup gravity

func jump(): # Function for the player's up movement = Jump
	# When the player press "W" button and if the chick is on the floor that means it isn't on the seiling
	if Input.is_action_pressed("Jump") and is_on_floor(): 
		motion.y = -JUMP_SPEED # going up with setup speed
		$JumpSFX.play() # Jumping sound effect
	
func move(): # Function for the player's left and right movement
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"): # When the player press only "A" button
		motion.x = -SPEED # The chick moves left with setup speed
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"): # When the player press only "D" button
		motion.x = SPEED # The chick moves right with setup speed
	else:
		motion.x = 0 # The chick does not move

func animate(): # Function for the player animation 
	emit_signal("animate", motion) # Depends on the motion then the player's animation changes
	

func hurt():
	position.y -= 1 # When the chick hurt, it moves one up,
	# Using yield to stop the frame for keeping the chick off the ground, 
	# so that the "Jump" condition is not false (The chick is not on the ceiling) so it can jump up
	yield(get_tree(),"idle_frame") 
	motion.y = -JUMP_SPEED # when the chick hurt, it jump as hurting reaction
	$PainSFX.play() # Hurt sound effect


func boost(): # Function for jump pad
	position.y -= 1 # When the chick on a jump pad, it moves one up
	# Using yield to stop the frame for keeping the chick off the ground, 
	# so that the "Jump" condition is not false (The chick is not on the ceiling) so it can jump up
	yield(get_tree(),"idle_frame")
	motion.y = -JUMP_SPEED * BOOST_MULTIPLAYER # the chick jumps up with setup jump speed times booster
	$BoostSFX.play() # Jump pad sound effect



