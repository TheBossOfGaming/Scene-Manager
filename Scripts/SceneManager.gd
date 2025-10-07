extends Node

enum Actions {
	DELETE,
	HIDE
}

enum Transitions {
	FADETOBLACK,
	PIXELDEATH,
}

func FadeToBlack() -> void:
	print("Should do a fade to black transition")
	
func PixelDeath() -> void:
	print("Should do a pixel death transition")

func ChangeScene(scene : PackedScene, Action : Actions, currentScene : Node, transition : Transitions) -> Node:
	# Has to change the scene to a new scene #
	match Action:
		Actions.DELETE:
			currentScene.queue_free()
		Actions.HIDE:
			currentScene.visible = false
	match transition:
		Transitions.FADETOBLACK:
			FadeToBlack()
		Transitions.PIXELDEATH:
			PixelDeath()
	
	var sceneworld = scene.instantiate()
	get_tree().root.add_child(sceneworld)
	
	return sceneworld
