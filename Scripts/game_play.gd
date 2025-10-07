#Basic node functinoality #
extends Node
class_name GamePlay

# Signals #
signal LoadStart
signal LoadCompleted
signal SceneAdded

# Export Varibles #

# Varibles #
@onready var hud: Control = $HUD
@onready var areas_loaded: Node3D = $AreasLoaded

var lastArea

func LoadScreenStart(loadingScreen) -> void:
	pass

func OnSceneAdded(area, loadingScreen) -> void:
	pass

func OnLoadCompleted(area) -> void:
	lastArea = area

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(areas_loaded.get_child_count() - 1)
	LoadStart.connect(LoadScreenStart)
	SceneAdded.connect(OnSceneAdded)
	LoadCompleted.connect(OnLoadCompleted)
	pass # Replace with function body.
