extends Control

var tweens = []
var started = false
@export var inTime : float = .5
@export var fadeInTime : float = 1.5
@export var pauseTime : float = .5
@export var fadeOutTime : float = 1.5
@export var outTime : float = .5
@export var FinishedLoadScene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var splashscreens : Array = self.get_children()
	#First fading out all the screens#
	for screen : Control in splashscreens:
		# Goes through both screen 1 and 2 async modulate.a into 0.0 #
		screen.modulate.a = 0.0
	#Fade the screens back in slowly#
	for screen in splashscreens:
		#Here put await so that it waits for each screen in splashscreens to finish fading and then does the next screen #
		await(fade(screen))
	startGame()

func startGame() -> void:
	if started == false:
		#print("Started == false spawning world")
		SceneManager.ChangeScene(FinishedLoadScene, get_tree().root, self, SceneManager.Actions.DELETE, SceneManager.TransitionsTypes.FADETOBLACK)
		started = true
	else:
		print_debug("Game has already started")

func fade(screen):
	var tween = self.create_tween()
	#var datetime_string = Time.get_datetime_string_from_system(false, true) # (include_date, include_time)
	#print("Tween has been made Screen: ", screen, " Time: ", datetime_string)
	tweens.append(tween)
	tween.tween_interval(inTime) 
	tween.tween_property(screen, "modulate:a", 1.0, fadeInTime)
	tween.tween_interval(pauseTime)
	tween.tween_property(screen, "modulate:a", 0.0, fadeOutTime)
	tween.tween_interval(outTime)
	await tween.finished
	#var datetime_string2 = Time.get_datetime_string_from_system(false, true) # (include_date, include_time)
	#print("Tween has finished Screen: ", screen, " Time: ", datetime_string2)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		print("Should skip the photo")
		startGame()
