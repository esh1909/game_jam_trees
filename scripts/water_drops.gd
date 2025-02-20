extends Area2D

@onready var game_manager: Node

@onready var animation_player: AnimationPlayer = %AnimationPlayer

@export var health: float = 1


func _ready() -> void:
	game_manager = get_tree().root.get_node("/root/Game/GameManager")
	$PickUpSound.finished.connect(self.queue_free)
	randomize()
	var pitch_offset = (randi() % 4) 
	$PickUpSound.pitch_scale = 1.2 + pitch_offset
	print($PickUpSound.pitch_scale)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		game_manager.add_point()
		
		for child in body.get_children():
			if child is WaterController:
				child.healed(health)
		animation_player.play("pickup")

		#print("coin collected")
