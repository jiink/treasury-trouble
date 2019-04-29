extends Sprite

func _process(delta):
	if Input.is_action_just_released("primary"):
		get_tree().change_scene("res://treasury.tscn")