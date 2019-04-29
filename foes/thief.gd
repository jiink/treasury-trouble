extends KinematicBody2D

var velocity
var speed = 40
export(bool) var enabled = true

enum{
	STOPPED,
	CHASING,
	START_COLLECTING,
	COLLECTING,
	KNOCKEDBACK,
	}
var state
var prevstate

var target

var max_hp = 6
var hp = max_hp

var knockbacktime = 0
var knockbackspeed = 0
var knockbackdir = 0

func _ready():
	state = CHASING if enabled else STOPPED
	$grab_zone.connect("body_entered", self, "on_body_enter")
	$grab_zone/grab_timer.connect("timeout", self, "grab_timer_timeout")
	target = find_goldpot("random")
	
	speed = 40 + get_node("../../../battle_manager").wave * 2
	$sprite.play("run")
	
func _process(delta):
	if state == STOPPED:
		pass
	
	elif state == CHASING:
		if target != null:
			look_at(target.position)
		var sidev = randf() * 4 - 2
		velocity = Vector2(1, sidev).rotated(rotation) * speed
		var r = rotation + PI/2
		if (r >= 0 and r < PI/2) or (r >= -3*PI/2 and r < 0):
			$sprite.flip_h = true
		else:
			$sprite.flip_h = false
		
		rotation = 0
		velocity = move_and_slide(velocity)
	
	elif state == START_COLLECTING:
		state = COLLECTING
		$grab_zone/grab_timer.start(1)
	
	elif state == KNOCKEDBACK:
		knockbacktime -= 1
		$sprite.stop()
		if knockbacktime <= 0:
			state = CHASING
			$sprite.play("run")
		move_and_slide(knockbackdir * knockbackspeed)
	
	# leave the following out if you want the thiefs
	# to look in a pot to see if it's empty

	if target.money <= 0:
		target = find_goldpot()
		state = CHASING
		$sprite.play("run")
	
func find_goldpot(mode = "nearest"):
	var goldpots = []
	for pot in get_tree().get_nodes_in_group("goldpots"):
		if pot.money > 0:
			goldpots.append(pot)
	
	if goldpots.size() > 0:
		if mode == "nearest":
			# nearest one
			#var goldpots = get_tree().get_nodes_in_group("goldpots")
			var nearest_goldpot = goldpots[0]
			for goldpot in goldpots:
				if goldpot.global_position.distance_to(global_position) < nearest_goldpot.global_position.distance_to(global_position):
					if goldpot.money > 0:
						nearest_goldpot = goldpot
			
			return nearest_goldpot
		elif mode == "random":
			var index = int(randf()*3)
			print(index)
			return get_tree().get_nodes_in_group("goldpots")[index]

func on_body_enter(body):
	if body.get_node("..").is_in_group("goldpots"):
		if body.get_node("..").money > 0 and body.get_node("..").name == target.name:
			state = START_COLLECTING
			$sprite.play("take")
		else:
			target = find_goldpot()

func on_body_exit(body):
	if body.get_node("..").is_in_group("goldpots"):
		state = CHASING
		$sprite.play("run")
		

func grab_timer_timeout():
	if target != null:
			target.remove_money(int(randi() % 100) + 69)
			
			if target.money <= 0:
				target = find_goldpot()
	
func get_hurt(d):
	hp -= d
	print("%s got hurt" % name)
	if hp <= 0:
		die()

func be_knocked_back(power, pos):
	knockbacktime = 10
	knockbackspeed = power
	
	print(position.angle_to_point(pos))
	knockbackdir = Vector2(0,-1).rotated(position.angle_to_point(pos) - 3*PI/2)
	prevstate = state
	state = KNOCKEDBACK

func die():
	queue_free()