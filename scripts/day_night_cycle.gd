extends CanvasModulate
#full day cycle 1440 segments
#one day calculation 2 * PI

var time : float = 0.0
#to emit signal only when time changes, not every frame
var past_minute: float = -1.0

@export var gradient = GradientTexture1D
#adjusting speed of day/night cycle 1 real-time second= 1 in-game minute
@export var INGAME_SPEED = 1.0
#time game should start at
@export var INITIAL_HOUR = 12:
	set(h):
		INITIAL_HOUR = h
		time = INGAME_TO_REAL_MINUTE_DURATION * INITIAL_HOUR * MINUTES_PER_HOUR

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

signal time_tick (day:int, hour:int, minute:int)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time = INGAME_TO_REAL_MINUTE_DURATION * INITIAL_HOUR * MINUTES_PER_HOUR


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta * INGAME_TO_REAL_MINUTE_DURATION * INGAME_SPEED
	var value = (sin(time - PI /2) + 1.0) / 2.0
	self.color = gradient.gradient.sample(value)
	_recalculate_time()
	
	
func _recalculate_time() -> void:
	#total in-game minutes passed since start of game
	var total_minutes = int(time/INGAME_TO_REAL_MINUTE_DURATION)
	
#	calculate current day
	var day = int (total_minutes/MINUTES_PER_DAY)
	
#	calculate hours and minutes
	var current_day_minutes = total_minutes % MINUTES_PER_DAY
	var hour = int (current_day_minutes/MINUTES_PER_HOUR)
	var minute = int (current_day_minutes % MINUTES_PER_HOUR)
	
	if past_minute != minute:
		past_minute = minute
		time_tick.emit(day, hour, minute)
