extends Area2D

export(float) var SPEED = 1000
var direction = Vector2.RIGHT

onready var velocity = direction.normalized() * SPEED

func _physics_process(delta):
	position += velocity * delta

	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.has_method("hit_by_projectile"):
			body.hit_by_projectile()
	if bodies:
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
