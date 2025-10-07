extends Control

@onready var panel: Panel = $Panel

signal LoadCompleted

#Making it visable
func Before() -> void:
	print("Tweening to appear")
	var tween = self.create_tween()
	tween.tween_property(panel, "modulate:a", 1.0, 1)
	await tween.finished

#Making it invisable#
func After() -> void:
	print("Tweening to dissapear")
	var tween = self.create_tween()
	tween.tween_property(panel, "modulate:a", 0.0, 1)
	await tween.finished
	self.queue_free()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#LoadCompleted.connect(After)
	Before()
	
