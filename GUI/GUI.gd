extends CanvasLayer

func _ready():
	$Control/TextureRect/HBoxContainer/LifeCount.text = "3"
	

func update_GUI(lives_left, coins, collectableItems):
	$Control/TextureRect/HBoxContainer/LifeCount.text = str(lives_left)
	$Control/TextureRect/HBoxContainer/CoinCount.text = str(coins)
	$Control2/TextureRect/VBoxContainer/HBoxContainer/CollectableItemCount.text = str(collectableItems)
	
