extends Button

func _ready():
	connect("pressed", self, "on_press")

func on_press():
	get_owner().get_node("../wave_timer").start(0.1)
	get_tree().call_group("foes", "die")