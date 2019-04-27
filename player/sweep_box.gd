extends Node2D

func _ready():
	visible = false

func wake():
	visible = true
	look_at(get_global_mouse_position())
	
	$Area2D.monitoring = true
	$Area2D.monitorable = true
	
	$timer.start(0.3)

func _on_timer_timeout():
	$Area2D.monitoring = false
	$Area2D.monitorable = false
	visible = false
