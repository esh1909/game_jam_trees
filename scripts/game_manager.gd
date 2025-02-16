extends Node

@onready var hud: CanvasLayer = $"../HUD"
@export var water_needed: float = 5
@export var day_night: Node
@export var player: Node

var time_hour = 0
var GAME_OVER = preload("res://scenes/GameOverScreen.tscn").instantiate()

func _ready() -> void:
	day_night.connect("time_tick", on_time_tick)
	EventController.connect("on_die", _on_dead)

func _on_dead(node: Node):
	if node == player:
		get_tree().root.add_child(GAME_OVER)
		# @warning_ignore("unused_variable")
		# var curr_scene = get_node("/root/Game")
		#get_tree().root.remove_child(curr_scene)
		#curr_scene.queue_free()
		
		

	
func on_time_tick(_day: int, hour: int, _minute: int):
	time_hour = hour
	
func is_night() -> bool:
	return time_hour >= 18 or time_hour <= 6

func add_point():
	pass
