extends Node2D

export(int) var money_capacity = 20000
var money = money_capacity

func remove_money(amount):
	money -= amount