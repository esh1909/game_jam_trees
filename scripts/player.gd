class_name Player extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -375.0

var dead: bool = false
var _is_day = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	EventController.connect("day_started", on_day_start)
	EventController.connect("night_started", on_night_start)
	EventController.connect("on_die", on_dead)
	
func on_dead(node: Node):
	if node == self and not $DeathSound.playing:
		$DeathSound.play(0)
	
func on_day_start():
	$SunController.health_drop_rate = -0.1
	$WaterController.health_drop_rate = 0.5
	_is_day = true
	
func on_night_start():
	$SunController.health_drop_rate = 0.1
	$WaterController.health_drop_rate = 0.1
	_is_day = false

func _physics_process(delta: float) -> void:
	if dead:
		return
	
	if _is_day:
		if position.y < 60:
			print("sun!")
			$SunController.health_drop_rate = -0.1
		else:
			print("too low")
			$SunController.health_drop_rate = 0.1
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0 , 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction > 0:
		animated_sprite_2d.flip_h = true
	elif direction < 0:
		animated_sprite_2d.flip_h =  false
		
# Play animations

	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
	#
	# Applies the movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
