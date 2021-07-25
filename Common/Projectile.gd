extends KinematicBody2D

export(float) var SPEED = 1000
var direction = Vector2.RIGHT

onready var velocity = direction.normalized() * SPEED

func _physics_process(delta):
	move_and_slide(velocity)
