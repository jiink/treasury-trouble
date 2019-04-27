extends Label

onready var gp = get_owner()

func _process(delta):
	text = ("%s / %s" % [gp.money, gp.money_capacity])