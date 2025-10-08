extends Control
class_name LoadingScreen

@onready var panel: Panel = $Panel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal Transition_To_Finshed

var animationsThatPlayed

func StartTransition(transitionstype) -> void:
	if !animation_player.has_animation(transitionstype):
		push_warning("Transition Type not found")
	print("Should do the transition type ", transitionstype)
	animationsThatPlayed = transitionstype
	animation_player.play(transitionstype)

func finish_transition() -> void:
	var ending_animation_name:String = animationsThatPlayed.replace("to","from")
	
	if !animation_player.has_animation(ending_animation_name):
		push_warning("'%s' animation does not exist" % ending_animation_name)
		ending_animation_name = "fade_from_black"
	animation_player.play(ending_animation_name)
	# once this final animation plays, we can free this scene
	await animation_player.animation_finished
	queue_free()

func Transition_To_Done() -> void:
	Transition_To_Finshed.emit()
	
func Transition_From_Done() -> void:
	pass
