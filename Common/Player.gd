extends KinematicBody2D

onready var animation = $AnimatedSprite

const GRAVITY = 20
const FRICTION = 0.2
const ACCELERATION = 100

const JUMP_FORCE = -600
const SHORT_HOP = 0.3

var velocity = Vector2.ZERO

func _physics_process(delta):
	var horizontal_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x += ACCELERATION * horizontal_movement
	velocity.x = lerp(velocity.x, 0, FRICTION)

	if horizontal_movement != 0:
		animation.play("Run")
		animation.flip_h = horizontal_movement < 0
	else:
		animation.play("Idle")

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y += JUMP_FORCE
	if velocity.y < 0 and Input.is_action_just_released("jump"):
		velocity.y = lerp(velocity.y, 0, SHORT_HOP)
	velocity.y += GRAVITY

	velocity = move_and_slide(velocity, Vector2.UP)
