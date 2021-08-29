extends KinematicBody2D

export(int) var health = 10

onready var tween = $Tween
signal dies

func hit_by_projectile():
	suffer_damage(1)

func decrease_health(hit_points):
	health -= hit_points
	if health <= 0:
		emit_signal("dies")
		on_death()

func on_death():
	queue_free()

func suffer_damage(healt_loss: int):
	tween.interpolate_property(self, "modulate", Color.white, Color.red, 0.1)
	tween.interpolate_property(self, "modulate", Color.red, Color.white, 0.1)
	tween.start()
	decrease_health(healt_loss)
