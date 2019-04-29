extends Node2D

func _ready():
	$ColorRect/reset_button.connect("pressed", self, "on_press")
	$AnimationPlayer.play("drop_down")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "drop_down":
		get_tree().paused = true
	elif anim_name == "drop_up":
		queue_free()

func on_press():
	print("resetting...")
	get_tree().paused = false
	
	var player = $"../../sort/player"
	player.pow_lvl = 1
	player.spd_lvl = 1
	player.abl_lvl = 1
	player.update_wepstats()
	player.alive = true
	
	var shop = $"../../sort/shopcart"
	for btn in get_tree().get_nodes_in_group("upgradebuttons"):
		btn.num_tag.text = str(1)
	
	var battle = $"../../battle_manager"
	battle.wave = 1
	battle.preptime = 15
	battle.wavetime = 40
	battle.state = battle.START_PREP

	for guy in get_tree().get_nodes_in_group("foes"):
		guy.die()
	
	for pot in get_tree().get_nodes_in_group("goldpots"):
		pot.money = pot.money_capacity
		
	$AnimationPlayer.play("drop_up")