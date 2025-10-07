#Node Stuff#
extends Node
#Signals#
signal LoadStart
signal LoadCompleted
signal SceneAdded
#TransitionScenes
const FADE_TO_BLACK = preload("res://Scenes/Transitions/fade_to_black.tscn")

#Actions that we can take#
enum Actions {
	DELETE,
	HIDE
}
#All the Transitions we can do#
enum Transitions {
	FADETOBLACK,
	PIXELDEATH,
}

var hiddenScenes = []

# Starts the transition (Fire LoadStart, screen should be black)
# Takes care of past scene (Does Action : so deletes or hide past scene)
# Loads the new scene (Fire SceneAdded)
# Finishes the transition (Fires LoadCompleted)
# Management done

func FadeToBlack() -> Control:
	print("Should do a fade to black transition")
	var scene = FADE_TO_BLACK.instantiate()
	return scene
	
func PixelDeath() -> Control:
	print("Should do a pixel death transition")
	var scene = FADE_TO_BLACK.instantiate()
	return scene

func ChangeScene(scene : PackedScene, PlaceNodeInHere : Node, PastScene : Node, Action : Actions, transition : Transitions) -> void:
	# Does the transition #
	match transition:
		Transitions.FADETOBLACK:
			var loadingscreen = FadeToBlack()
			print_debug("Sending Loading Screen Signal")
			LoadStart.emit(loadingscreen)
		Transitions.PIXELDEATH:
			print_debug("Sending Loading Screen Signal")
			var loadingscreen = PixelDeath()
			LoadStart.emit(loadingscreen)

	#Spawns in and adds the node to the location#
	var newScene = scene.instantiate()
	PlaceNodeInHere.add_child(newScene)
	SceneAdded.emit()

	# Has to change the scene to a new scene #
	match Action:
		Actions.DELETE:
			PastScene.queue_free()
			LoadCompleted.emit()
		Actions.HIDE:
			PastScene.visible = false
			hiddenScenes.append(PastScene)
			LoadCompleted.emit()
