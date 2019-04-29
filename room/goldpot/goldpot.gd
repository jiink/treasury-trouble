extends Node2D

export(int) var money_capacity = 20000
export(int) var money = 20000
#var money = money_capacity

func remove_money(amount):
	money -= amount
	if money < 0:
		money = 0
		
	if money == 0:
		$sprite.frame = 0
	else:
		$sprite.frame = int(round(float(money)/float(money_capacity) * 2.0)) + 1
	