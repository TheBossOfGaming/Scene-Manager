#Basic node functinoality #
extends Node
class_name GamePlay

# Export Varibles #

# Varibles #
@onready var hud: Control = $HUD
@onready var areas_loaded: Node3D = $AreasLoaded

var currentArea

#func LoadScreenStart(loadingScreen : Control) -> void:
	#print("LoadStart Connected")
	#loadingScreen.reparent(hud)
#
#func OnSceneAdded(area, loadingScreen) -> void:
	#pass 

func OnLoadCompleted(area) -> void:
	#print(area)
	currentArea = area

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#SceneManager.LoadStart.connect(LoadScreenStart)
	#SceneManager.SceneAdded.connect(OnSceneAdded)
	SceneManager.LoadCompleted.connect(OnLoadCompleted)
	currentArea = $AreasLoaded/StartingArea
	pass # Replace with function body.
