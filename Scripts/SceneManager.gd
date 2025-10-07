#Node Stuff#
extends Node
#Signals#

#TransitionScenes
const LOADING_SCREEN = preload("res://Scenes/Transitions/LoadingScreen.tscn")

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
var loadingScreen : LoadingScreen

# Starts the transition (Fire LoadStart, screen should be black)
# Takes care of past scene (Does Action : so deletes or hide past scene)
# Loads the new scene (Fire SceneAdded)
# Finishes the transition (Fires LoadCompleted)
# Management done

func addLoadingScreen(transitionsType) -> void:
	loadingScreen = LOADING_SCREEN.instantiate()
	get_tree().root.add_child(loadingScreen)
	loadingScreen.StartTransition(transitionsType)
	
func LoadContent() -> void:
	pass

func ChangeScene(scene : PackedScene, PlaceNodeInHere : Node, PastScene : Node, Action : Actions, transition : Transitions) -> void:
	# Does the transition #
	match transition:
		Transitions.FADETOBLACK:
			var type = "fade_to_black"
			addLoadingScreen(type)
			print_debug("Sending Loading Screen Signal")
		Transitions.PIXELDEATH:
			var type = "fade_to_black"
			addLoadingScreen(type)
			print_debug("Sending Loading Screen Signal")
			
	await(loadingScreen.Transition_To_Finshed)
	
	#Spawns in and adds the node to the location#
	var newScene = scene.instantiate()
	PlaceNodeInHere.add_child(newScene)

	# Has to change the scene to a new scene #
	match Action:
		Actions.DELETE:
			PastScene.queue_free()
			loadingScreen.finish_transition()
		Actions.HIDE:
			PastScene.visible = false
			hiddenScenes.append(PastScene)
			loadingScreen.finish_transition()
