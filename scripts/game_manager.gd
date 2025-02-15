extends Node

var score = 0
#@onready var score_label: Label = %ScoreLabel

@onready var hud: CanvasLayer = $"../HUD"
var GAME_OVER = preload("res://scenes/GameOverScreen.tscn").instantiate()


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
		
		
