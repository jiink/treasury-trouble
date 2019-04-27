extends Camera2D

export(bool) var follow_player = true

func _process(delta):
	if follow_player:
		position = Vector2(int(get_node("../sort/player").position.x),
						   int(get_node("../sort/player").position.y))