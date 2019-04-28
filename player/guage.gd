extends TextureProgress

export(String, 'a', 'b', 'c') var letter = 'a'

onready var treas = get_node("/root/treasury")
var gpot

func _ready():
	match letter:
		'a':
			gpot = treas.goldpot_a
		'b':
			gpot = treas.goldpot_b
		'c':
			gpot = treas.goldpot_c
			
	gpot = get_node("/root/treasury/" + gpot)
	print(gpot)
	max_value = gpot.money_capacity

func _process(delta):
	value = gpot.money