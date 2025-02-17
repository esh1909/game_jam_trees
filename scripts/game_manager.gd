extends Node

@onready var hud: CanvasLayer = $"../HUD"
@export var day_night: Node
@export var player: Node
@export var audio_player: AudioStreamPlayer

var _is_game_over: bool = false
var time_hour = 0
var GAME_OVER: Node

var _LEVELS: Array[String] = ["res://scenes/level1.tscn", "res://scenes/level_2.tscn"]
var next_level = 1
var current_level_node: Node

func _ready() -> void:
	day_night.connect("time_tick", on_time_tick)
	EventController.connect("on_die", _on_dead)
	EventController.connect("day_started", _on_day_start)
	GAME_OVER = load("res://scenes/GameOverScreen.tscn").instantiate()
	GAME_OVER.get_node("CanvasLayer/Restart").connect("pressed", _restart_game)
	current_level_node = get_tree().root.get_node("/root/Game/Level")
	audio_player.set_bus("Master")

func _restart_game():
	GAME_OVER.queue_free()
	get_tree().reload_current_scene()
	_is_game_over = false
	audio_player.set_bus("Master")

func _load_new_level():
	var game_node: Node = get_tree().root.get_node("/root/Game")
	var next_level_scene: Node = load(_LEVELS[next_level%len(_LEVELS)]).instantiate()
	print("Add lvl")
	game_node.add_child(next_level_scene)
	next_level_scene.name = "Level"
	next_level += 1
	current_level_node.queue_free()
	current_level_node = next_level_scene
	player.position = Vector2(0,0)

func _on_dead(node: Node):
	if node == player and not _is_game_over:
		get_tree().root.add_child(GAME_OVER)
		audio_player.set_bus("Muffled")
		_is_game_over = true
		# @warning_ignore("unused_variable")
		# var curr_scene = get_node("/root/Game")
		#get_tree().root.remove_child(curr_scene)
		#curr_scene.queue_free()
		
func on_time_tick(_day: int, hour: int, _minute: int):
	time_hour = hour
	
func is_night() -> bool:
	return time_hour >= 18 or time_hour <= 6

func _on_day_start():
	_load_new_level()

func add_point():
	pass
	# var game_node: Node = get_tree().root.get_node("/root/Game")
	# if next_level == 1:
	# 	var current_level_scene: Node = _LEVELS[next_level].instantiate()
	# 	print("Add lvl")
	# 	game_node.add_child(current_level_scene)
	# 	game_node.get_node("Level").queue_free()
	# 	current_level_scene.name = "Level"
	# 	next_level += 1
