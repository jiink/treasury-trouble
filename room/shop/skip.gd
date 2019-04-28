extends Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "on_pressed")

func on_pressed():
	var btl = get_owner().get_node("../../battle_manager")
	var wavetimer = get_owner().get_node("../../wave_timer")
	if btl.state == btl.PREP:
		wavetimer.start(0.1)