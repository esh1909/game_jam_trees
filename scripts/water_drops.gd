extends Area2D

@onready var game_manager: Node

@onready var animation_player: AnimationPlayer = %AnimationPlayer

@export var health: float = 1


func _ready() -> void:
	game_manager = get_tree().root.get_node("/root/Game/GameManager")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		game_manager.add_point()
		
		for child in body.get_children():
			if child is HealthController:
				child.healed(health)
		queue_free()
		animation_player.play("pickup")
		#print("coin collected")
