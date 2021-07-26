extends "res://Common/Characters/Character.gd"

onready var weapon = $Weapon

func _on_Vision_target_found(collision_point: Vector2):
	weapon.global_aim_position = collision_point
	weapon.shoot()
