extends Node3D
class_name Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(2.0).timeout # Pauses for 2 seconds
	self.queue_free()
