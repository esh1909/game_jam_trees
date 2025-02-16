class_name HealthController extends Node

@export var health: float: set = _set_health, get = _get_health
@export var health_drop_rate: float = 0.1

var _start_drop: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventController.connect("on_health_ui_ready", on_event_health_ui_ready)
	
func _process(delta: float) -> void:
	if _start_drop:
		health -= health_drop_rate * delta

func on_event_health_ui_ready(node: Node) -> void:
	EventController.emit_signal("on_health_changed", node, health)
	_start_drop = true

func _set_health(value: float) -> void:
	print("set health "+ str(value))
	var parent: Node = get_parent()
	if value <= 0:
		print('You dead!')
		EventController.emit_signal("on_die", parent)
	else:
		print('health: ', value)
		if parent:
			EventController.emit_signal("on_health_changed", parent, value)
		health = value
		
func _get_health():
	return health

func hurt(value):
	health -= value
	
func healed(value):
	health += value
