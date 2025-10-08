extends Node3D

var newArea = preload("res://Scenes/starting_node_2.tscn")
@export var PlayerScene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(2.0).timeout # Pauses for 2 seconds
	print("Going to next scene")
	var loadedScene = PlayerScene.instantiate()
	self.add_child(loadedScene)
	await get_tree().create_timer(3.0).timeout # Pauses for 2 seconds
	SceneManager.ChangeScene(newArea, self.get_parent(), self, SceneManager.Actions.HIDE, SceneManager.TransitionsTypes.SWIPETOLEFT)
