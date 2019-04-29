extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	print("splat spawned!")
	$CPUParticles2D.emitting = true

func _on_Timer_timeout():
	print("splat gone")
	queue_free()
