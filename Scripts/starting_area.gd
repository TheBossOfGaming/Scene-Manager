extends Node3D

var newArea = preload("res://Scenes/starting_node_2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(2.0).timeout # Pauses for 2 seconds
	print("Going to next scene")
	SceneManager.ChangeScene(newArea, SceneManager.Actions.HIDE, self, SceneManager.Transitions.PIXELDEATH)
