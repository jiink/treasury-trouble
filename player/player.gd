extends KinematicBody2D

var weapons = ["sword", "crossbow"]
var wep_i = 0
var weapon = weapons[wep_i]
var damage = 3

var swing_delay = 0.3

var pow_lvl = 1
var spd_lvl = 1
var abl_lvl = 1

var wep_pow
var wep_spd 
var wep_abl

var alive = true

func _ready():
	update_wepstats()

func _process(delta):
	if Input.is_action_just_released("a"):
		if wep_i == 0:
			wep_i = 1
		else:
			wep_i = 0
	weapon = weapons[wep_i]
	
	if Input.is_action_just_released("primary"):
		if weapon == "sword" and $sweep_box/timer.is_stopped():
			attack_melee()
			$sweep_box/timer.start(swing_delay)

func attack_melee():
	$sweep_box.wake(damage, wep_pow)

func update_wepstats():
	wep_pow = pow_lvl * 100.0
	wep_spd = 1 - spd_lvl * 0.1
	wep_abl = abl_lvl