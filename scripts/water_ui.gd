extends Control

@export var player: Node
@onready var water_ui_empty: TextureRect = $WaterUIEmpty
@onready var water_ui_full: TextureRect = $WaterUIFull

var max_water: float = 0: set = _set_max_water, get = _get_max_water
var water: float = 0.0: set = _set_water, get = _get_water

func _ready() -> void:
	EventController.connect("on_health_changed", on_event_health_changed)
	EventController.connect("on_max_health_changed", on_event_max_health_changed)
	
	EventController.emit_signal("on_health_ui_ready", player)
	
func _set_water(value:float) -> void:
	print("set "+str(value))
	water = clamp(value, 0, max_water)
	if water_ui_full != null and max_water != 0:
		water_ui_full.set_size(Vector2(value*365, 365))
		print(water_ui_full.size)
			
func _get_water() -> float:
	return water

func _set_max_water(value:float) ->void:
	max_water = max(value, 1)
	if water_ui_empty !=null:
		water_ui_empty.set_size(Vector2(value * 32, 32))

func _get_max_water() -> float:
	return max_water

func on_event_max_health_changed(node: Node, new_max_water: float):
	if node == player:
		max_water = new_max_water

func on_event_health_changed(node: Node, new_water: float):
	if node == player:
		water = new_water
