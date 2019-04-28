extends KinematicBody2D

var velocity
export(float) var speed = 25
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
	
func _process(delta):
	if state == STOPPED:
		pass
	
	elif state == CHASING:
		if target != null:
			look_at(target.position)
		var sidev = randf() * 4 - 2
		velocity = Vector2(1, sidev).rotated(rotation) * speed
		rotation = 0
		velocity = move_and_slide(velocity)
	
	elif state == START_COLLECTING:
		state = COLLECTING
		$grab_zone/grab_timer.start(1)
	
	elif state == KNOCKEDBACK:
		knockbacktime -= 1
		if knockbacktime <= 0:
			state = CHASING
		move_and_slide(knockbackdir * knockbackspeed)

func find_goldpot(mode = "nearest"):
	if mode == "nearest":
		# nearest one
		var goldpots = get_tree().get_nodes_in_group("goldpots")
		var nearest_goldpot = goldpots[0]
		for goldpot in goldpots:
			if goldpot.global_position.distance_to(global_position) < nearest_goldpot.global_position.distance_to(global_position):
				nearest_goldpot = goldpot
		
		return nearest_goldpot
	elif mode == "random":
		return get_tree().get_nodes_in_group("goldpots")[int(randf()*3)]

func on_body_enter(body):
	if body.get_node("..").is_in_group("goldpots"):
		state = START_COLLECTING

func on_body_exit(body):
	if body.get_node("..").is_in_group("goldpots"):
		state = CHASING

func grab_timer_timeout():
	target.remove_money(73)
	
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