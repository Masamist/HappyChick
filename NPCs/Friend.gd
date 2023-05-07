extends Node2D

var collectionTask = false

func update_collection(TaskDone):
	collectionTask = TaskDone
	if collectionTask:
		$Area2D/Message/ItemImage.visible = not $Area2D/Message/ItemImage.visible
