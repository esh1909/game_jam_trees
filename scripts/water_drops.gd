extends Area2D

@onready var game_manager: Node = %GameManager

@onready var animation_player: AnimationPlayer = %AnimationPlayer

@export var health: float = 1

func _on_body_entered(body: Node2D) -> void:
	game_manager.add_point()
	
	for child in body.get_children():
		if child is HealthController:
			child.healed(health)
	queue_free()
	animation_player.play("pickup")
	#print("coin collected")
