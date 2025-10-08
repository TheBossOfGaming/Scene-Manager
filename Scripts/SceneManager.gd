#Node Stuff#
extends Node
#Signals#
signal LoadCompleted
#TransitionScenes
const LOADING_SCREEN = preload("res://Scenes/Transitions/LoadingScreen.tscn")

#Actions that we can take#
enum Actions {
	DELETE,
	HIDE,
}
#All the Transitions we can do#
# Types of transitions here for easy auto completion #
const TransitionsTypes : Dictionary[String, String] = {
	FADETOBLACK = "fade_to_black",
	SWIPETOLEFT = "swipe_to_right",
}

var hiddenScenes = []
var loadingScreen : LoadingScreen

func DealWithAction(Action, PastScene, instantiateScene) -> void:
	# Has to change the scene to a new scene #
	match Action:
		Actions.DELETE:
			PastScene.queue_free()
			LoadCompleted.emit(instantiateScene)
			loadingScreen.finish_transition()
		Actions.HIDE:
			PastScene.hide()
			hiddenScenes.append(PastScene)
			LoadCompleted.emit(instantiateScene)
			loadingScreen.finish_transition()

func ChangeScene(NewScene : PackedScene, PlaceNodeInHere : Node, PastScene : Node, Action : Actions, transition : String) -> void:
	# Does the transition #
	loadingScreen = LOADING_SCREEN.instantiate()
	get_tree().root.add_child(loadingScreen)
	loadingScreen.StartTransition(transition)
	await(loadingScreen.Transition_To_Finshed)
	
	#Spawns in and adds the node to the location#
	var instantiateScene = NewScene.instantiate()
	PlaceNodeInHere.add_child(instantiateScene)

	DealWithAction(Action, PastScene, instantiateScene)
			
func LoadPastScene(CurrentScene : Node, Action : Actions, transition : String) -> void:
	var pastScene : Node3D = hiddenScenes[0]
		# Does the transition #
	loadingScreen = LOADING_SCREEN.instantiate()
	get_tree().root.add_child(loadingScreen)
	loadingScreen.StartTransition(transition)
	await(loadingScreen.Transition_To_Finshed)
	
	#Unhidden past scene#
	pastScene.show()
	hiddenScenes.erase(pastScene)
	
	DealWithAction(Action, CurrentScene, pastScene)
