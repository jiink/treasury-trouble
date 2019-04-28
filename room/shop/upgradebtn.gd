extends TextureButton

var num_tag
var price_tag
var type
var player

var price

func _ready():
	connect("pressed", self, "on_press")
	type = $"..".name
	num_tag = $"../num"
	price_tag = $"../price"
	player = get_owner().get_node("../player")
	
	update_price()

func on_press():
	var lvl_var_name = "%s_lvl" % type
	player.set(lvl_var_name, player.get(lvl_var_name) + 1)
	player.update_wepstats()
	num_tag.text = str(player.get(lvl_var_name))

	update_price()
	

func update_price():
	match type:
		"spd":
			price = 5000
		"pow":
			price = 6000
		"abl":
			price = 6500
			
	price_tag.text = "$%1.2fk" % (price * 0.001)