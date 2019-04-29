extends Node2D

onready var sprite = get_node("area/CollisionShape2D/sprite")

func _ready():
#	visible = false
	pass
	
func wake(damage, power):
#	visible = true
	look_at(get_global_mouse_position())
	
#	$area.monitoring = true
#	$area.monitorable = true
	
	$timer.start(0.3)
	
	for body in $area.get_overlapping_bodies():
		if body.is_in_group("foes"):
			body.get_hurt(damage)
			#body.move_and_slide(Vector2(0,-1).rotated(body.get_global_position().angle_to_point($"..".position))*$"..".power)
			var p = $".."
			body.be_knocked_back(power, p.position)
			
	sprite.frame = 0
	sprite.playing = true

func _on_timer_timeout():
#	$area.monitoring = false
#	$area.monitorable = false
#	visible = false
	pass
