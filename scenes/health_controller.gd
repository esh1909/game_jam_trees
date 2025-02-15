class_name HealthController extends Node

@export var max_health: float : set = _set_max_health, get = _get_max_health
@export var health: float: set = _set_health, get= _get_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(max_health)
	EventController.connect("on_health_ui_ready", on_event_health_ui_ready)

func on_event_health_ui_ready(node: Node) -> void:
	print("Got signal " + str(max_health))
	EventController.emit_signal("on_max_health_changed", node, max_health)
	EventController.emit_signal("on_health_changed", node, health)

func _set_health(value: float) -> void:
	var parent: Node = get_parent()
	if value > max_health:
		print('Full health already')
	elif value <= 0:
		print('You dead!')
	else:
		print('health: ', value)
		if parent:
			EventController.emit_signal("on_health_changed", parent, value)	
		health = value
		
func _get_health():
	return health

func _set_max_health(value):
	var parent: Node = get_parent()
	max_health = value
	var new_health = max_health - health
	healed(new_health)
	if parent:
		EventController.emit_signal("on_max_health_changed", parent, value)
		
func _get_max_health():
	return max_health

func hurt(value):
	health -= value
	
func healed(value):
	health += value
	
func increased_max_health(value):
	max_health += value
