extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(2.0).timeout # Pauses for 2 seconds
	print("Going to back to past scene")
	SceneManager.LoadPastScene(self, SceneManager.Actions.HIDE, SceneManager.TransitionsTypes.SWIPETOLEFT)
