extends KinematicBody2D

export(int) var health = 10

onready var tween = $Tween

func hit_by_projectile():
	tween.interpolate_property(self, "modulate", Color.white, Color.red, 0.1)
	tween.interpolate_property(self, "modulate", Color.red, Color.white, 0.1)
	tween.start()
	decrease_health(1)

func decrease_health(hit_points):
	health -= hit_points
	if health <= 0:
		queue_free()
