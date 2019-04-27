extends Node

export (float) var max_speed = 100
export (float) var accel = 10
export (float) var friction = 0.7
var speed = 1.0

var motion = Vector2(0, 0)
var direction = "right"
var frozen = false

onready var target = get_node("..")
onready var aspr = target.get_node("sprite")

func _process(delta):
	if not frozen:
		get_inputs(delta)
	else:
		motion = Vector2(0,0)
	motion = motion.normalized()
	
	var movement = motion * speed
	target.move_and_slide(movement)
	
#	print(direction)
#	match direction:
#		"rightdown" or "down" or "right":
#			aspr.animation = "frontright"
#		"leftdown" or "left":
#			aspr.animation = "frontleft"
#		"rightup" or "up":
#			aspr.animation = "backright"
#		"leftup":
#			aspr.animation = "backleft"
	
func get_inputs(delta):
	#motion = Vector2(0, 0)
	if Input.is_action_pressed("up"):
		motion.y -= 1
	if Input.is_action_pressed("down"):
		motion.y += 1
		
		
	if Input.is_action_pressed("left"):
		motion.x -= 1
		aspr.animation = "frontleft"
	if Input.is_action_pressed("right"):
		motion.x += 1
		aspr.animation = "frontright"
	
	speed = clamp(speed, 0, max_speed)
	if Input.is_action_pressed("right") or Input.is_action_pressed("up") or Input.is_action_pressed("left") or Input.is_action_pressed("down"):
		speed += accel
		aspr.playing = true
	else:
		speed *= friction
		aspr.playing = false
		aspr.frame = 0
	
	match motion:
		Vector2(0, -1):
			direction = "up"
		Vector2(1, -1):
			direction = "rightup"
		Vector2(1, 0):
			direction = "right"
		Vector2(1, 1):
			direction = "rightdown"
		Vector2(0, 1):
			direction = "down"
		Vector2(-1, 1):
			direction = "leftdown"
		Vector2(-1, 0):
			direction = "left"
		Vector2(-1, -1):
			direction = "leftup"
	