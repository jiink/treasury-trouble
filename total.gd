extends Label

func _process(delta):
	text = "$%s" % $"../..".money_total