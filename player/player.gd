extends KinematicBody2D

var weapons = ["sword", "crossbow"]
var wep_i = 0
var weapon = weapons[wep_i]

func _process(delta):
	if Input.is_action_just_released("a"):
		if wep_i == 0:
			wep_i = 1
		else:
			wep_i = 0
	weapon = weapons[wep_i]
	
	if Input.is_action_just_released("primary"):
		if weapon == "sword":
			attack_melee()

func attack_melee():
	$sweep_box.wake()