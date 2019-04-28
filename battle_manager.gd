extends Node

var wave = 1
var preptime = 15
var wavetime = 40


onready var wave_info = get_node("../hud/wave_info")
onready var wave_timer = get_node("../wave_timer")




enum {
	WAIT,
	START_PREP,
	PREP,
	START_WAVE,
	IN_PROGRESS,
	}
var state

func _ready():
	wave_timer.connect("timeout", self, "timer_end")
	$spawn_timer.connect("timeout", self, "spawn_timer_end")
	state = START_PREP 
	
func _process(delta):
	var state_s
	match state:
		PREP:
			state_s = "Preperation"
		IN_PROGRESS:
			state_s = "In Progress"
		
			
			
	wave_info.text = "Wave %s: %s\n%s" % [wave, state_s, int(wave_timer.time_left)]
	if state == START_PREP:
		
		
		
		wave_timer.start(preptime)
		state = PREP
	
	
func timer_end():
	if state == PREP:
		state = IN_PROGRESS
		wave_timer.start(wavetime)
		$spawn_timer.start(1)
		
	elif state == IN_PROGRESS:
		state = PREP
		wave += 1
		wave_timer.start(preptime)

func spawn_foe(where, amount):
	for i in range(amount):
		var spawnpos = where + Vector2(int(randf()*5.0 - 2.5), int(randf()*5.0 - 2.5))
		var foe = load("res://foes/thief.tscn").instance()
		foe.position = spawnpos
		$"../sort/foes".add_child(foe)

func spawn_timer_end():
	spawn_foe($spawnpoints.get_children()[randi() % $spawnpoints.get_children().size()].position, randi() % 4)
	if state == IN_PROGRESS:
		$spawn_timer.start(randf() * 4 + 5)