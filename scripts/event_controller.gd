extends Node


#health controller
signal on_water_ui_ready(node: Node)
signal on_water_changed(node: Node, new_health: float)

signal on_sun_ui_ready(node: Node)
signal on_sun_changed(node: Node, new_health: float)

signal on_die(node: Node)

signal night_started()
signal day_started()
