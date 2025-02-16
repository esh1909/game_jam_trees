extends Node

var score = 0
#@onready var score_label: Label = %ScoreLabel

@onready var hud: CanvasLayer = $"../HUD"
@export var water_needed: float = 5
@export var day_night: Node

var time_hour = 0
var GAME_OVER = preload("res://scenes/GameOverScreen.tscn").instantiate()

func _ready() -> void:
	day_night.connect("time_tick", on_time_tick)
	
func on_time_tick(day:int, hour:int, minute:int):
	print(is_night())
	time_hour = hour
	
func is_night() -> bool:
	return time_hour >= 18 or time_hour <= 6

func add_point():
	score += 1
	#score_label.text = "You collected " + str(score) + " coins."
	hud.find_child('Label').text = "Coins: "+str(score) + "/20"
	if score == 20:
		print(score)
		get_tree().root.add_child(GAME_OVER)
		@warning_ignore("unused_variable")
		var curr_scene = get_node("/root/Game")
		#get_tree().root.remove_child(curr_scene)
		#curr_scene.queue_free()
		
		
