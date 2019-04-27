extends Node

var wave = 1
var preptime = 3
var wavetime = 10

onready var wave_info = get_node("hud/wave_info")

enum {
	WAIT,
	START_PREP,
	PREP,
	START_WAVE,
	IN_PROGRESS,
	}
var state

func _ready():
	$wave_timer.connect("timeout", self, "timer_end")
	state = START_PREP 
	
func _process(delta):
	var state_s
	match state:
		PREP:
			state_s = "Preperation"
		IN_PROGRESS:
			state_s = "In Progress"
			
	wave_info.text = "%s\n%s" % [state_s, int($wave_timer.time_left)]
	if state == START_PREP:
		$wave_timer.start(preptime)
		state = PREP
	
	
func timer_end():
	if state == PREP:
		state = IN_PROGRESS
		$wave_timer.start(wavetime)
		
	elif state == IN_PROGRESS:
		state = PREP
		$wave_timer.start(preptime)