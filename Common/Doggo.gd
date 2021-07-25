extends KinematicBody2D

onready var tween = $Tween

func hit_by_projectile():
	tween.interpolate_property(self, "modulate", Color.white, Color.red, 0.1)
	tween.interpolate_property(self, "modulate", Color.red, Color.white, 0.1)
	tween.start()
