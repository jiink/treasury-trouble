extends KinematicBody2D

var velocity
export(float) var speed = 40

enum{
	CHASING,
	START_COLLECTING,
	COLLECTING,
	}
var state

var target

func _ready():
	state = CHASING
	$grab_zone.connect("body_entered", self, "on_body_enter")
	$grab_zone/grab_timer.connect("timeout", self, "grab_timer_timeout")
	target = find_goldpot()
	
func _process(delta):
	if target != null:
		look_at(target.position)
	velocity = Vector2(1, 0).rotated(rotation) * speed
	rotation = 0
	velocity = move_and_slide(velocity)
	
	if state == START_COLLECTING:
		state = COLLECTING
		$grab_zone/grab_timer.start(1)
		

func find_goldpot():
	# nearest one
	var goldpots = get_tree().get_nodes_in_group("goldpots")
	var nearest_goldpot = goldpots[0]
	for goldpot in goldpots:
		if goldpot.global_position.distance_to(global_position) < nearest_goldpot.global_position.distance_to(global_position):
			nearest_goldpot = goldpot
	
	return nearest_goldpot

func on_body_enter(body):
	if body.get_owner().name.begins_with("goldpot"):
		state = START_COLLECTING

func on_body_exit(body):
	if body.get_owner().name.begins_with("goldpot"):
		state = CHASING

func grab_timer_timeout():
	target.remove_money(73)