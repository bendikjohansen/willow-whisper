extends Area2D

export(float) var SPEED = 1000
var direction = Vector2.RIGHT

onready var velocity = direction.normalized() * SPEED

func _physics_process(delta):
	position += velocity * delta

	if get_overlapping_bodies():
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
