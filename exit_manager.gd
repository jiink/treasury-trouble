extends Node2D

var initial = true

func _ready():
	$anim.connect("animation_finished", self, "anim_done")
	visible = false

func _process(delta):
	if Input.is_action_pressed("exit") and initial:
		$anim.play("default")
		visible = true
		initial = false
	if not Input.is_action_pressed("exit"):
		$anim.stop(true)
		visible = false
		initial = true

func anim_done(a):
	print("GAME EXITED!!")
	get_tree().quit()