extends Node2D

var lives = 3 # Life counts for chick
var coins = 0 # Coin count
var target_number_of_coins = 10 # Every 10 coins collected then you can get 1 extra life
var collectableItems = 0 # The number of speciall items collected by chick
var target_number_of_items = 3 # The target numbers of speciall items should be collected
var collectionTask = false # bool for checking that all speciall item has been collected or not

# Scene change signal
signal scene_changed(scene_name) # Signal if scene is chenged
signal scene_gameOver(scene_name) # Signal if game is over
export (String) var scene_name = "scene" # create scene name for switching the scene


func _ready():
	add_to_group("Gamestate")
	coins = GlobalData.coin_wallet # Get the coin_wallet information using Singleton
	update_GUI() # Update startup GUI information


func update_GUI(): # Call this function, when a number of lives, coins, collectableItems updated
	get_tree().call_group("GUI", "update_GUI", lives, coins, collectableItems) #Pass the information to scene "GUI


func hurt(): # Function for when player gets hurt 
	lives -= 1 # when the player collides a enemy or huzard loose one live
	update_GUI() # Update life info on the GUI
	$Player.hurt()
	if lives <0: # if lives get 0 then call the function "end_game" for game over
		end_game()

func life_up(): # Call the function when the player got 10 coins
	lives += 1 # Get one life
	update_GUI() # Update "GUI"


func coin_up(): # Function for coin count changes
	coins += 1
	update_GUI() # Update life info on the GUI
	var multiple_of_coins = (coins % target_number_of_coins) == 0 # Setup the condition for checking if the coin gets 10
	if multiple_of_coins: # When the condition is true, 
		life_up() # get life up function


func update_collection(): # Call this function to check if the player gets all the collectable items
	get_tree().call_group("Friend", "update_collection", collectionTask) # the speech mark of the animal friend at portal changes


func collectableItem_up(): # Function for collectable item count changes
	collectableItems += 1
	update_GUI() # Update life info on the GUI
#
	if collectableItems == target_number_of_items: # To check if the player gets all the collectable items
		collectionTask = true # If the condition is true 
		update_collection() # Then call this function to update the goal condition is clear
		#print("collected") 


func end_game(): # When the player got a game over, then this function is called
	GlobalData.coin_wallet = 0
	scene_name = "EndGame" # put the name of this scene name,
	emit_signal("scene_changed", scene_name) # then switch to the gave over scene
#	get_tree().change_scene("res://Levels/GameOver.tscn") # hard code


func win_game(): # When the player clear the game, then this function is called
	GlobalData.coin_wallet = coins
	if collectableItems == target_number_of_items: # Checking if the player has collected all the collectable items
		emit_signal("scene_changed", scene_name) # The condition is true, then this switches to the clear scene

