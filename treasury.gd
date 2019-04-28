extends Node

export(NodePath) var goldpot_a
export(NodePath) var goldpot_b
export(NodePath) var goldpot_c

var money_total


func _process(delta):
	money_total = get_node(goldpot_a).money + get_node(goldpot_c).money + get_node(goldpot_b).money
	