extends "res://Common/Characters/Character.gd"

onready var weapon = $Weapon

func _on_Vision_target_found(collision_point: Vector2):
	weapon.aim_at = collision_point - global_position
	weapon.shoot()
