extends Control

@export var player: Node
@onready var water_ui_full: TextureRect = $WaterUIFull
@export var texture: CompressedTexture2D

const WATER_SIZE: Vector2 = Vector2(32, 32)

var water: float = 0.0: set = _set_water, get = _get_water

func _ready() -> void:
	EventController.connect("on_sun_changed", on_event_health_changed)
	EventController.emit_signal("on_sun_ui_ready", player)
	water_ui_full.texture = texture
	
func _set_water(value:float) -> void:
	water = clamp(value, 0, INF)
	if water_ui_full != null:
		water_ui_full.set_size(WATER_SIZE*Vector2(water,1))
		# print(water_ui_full.size)
			
func _get_water() -> float:
	return water


func on_event_health_changed(node: Node, new_water: float):
	if node == player:
		water = new_water
